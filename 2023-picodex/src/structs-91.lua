-- this file contains structures for:
-- pokemon
-- team_pokemon
-- active_pokemon
-- team

-- thanks to bulbapedia: https://bulbapedia.bulbagarden.net/wiki/Stat#Stat
-- this formula is much simpler at lvl 50, so I took some parts out.
--|[f_calc_max_stat]| function(base)
--    return _ceil(base+.5*93)+5
--end $$

|[f_create_team_pkmn]| function()

end $$

-- party: team power, alive size
-- pokemon: 

-- 3 levels of pokemon: browse, fightable, party, active

-- ok, maybe there can be 1 base template with default values.
-- you just copy a previous one to do whatever

-- CURRENT BROWSE PKMN
---------------------- these never change
-- pkmn {
--   evolvesfrom
--   name
--   type1
--   type2
--   level -- constant of 50
--   movelvls
--   moves_learnable
--   draw
--   num
--   total   -- all the previous stats added together
--   here, move ids is all the possible moves... maybe
-- }
---------------- these change
-- teampkmn { -- index metatable to pkmn
--   hp, hurt(), heal() -- should take in the 
--   set_major
--   moveids
--   movepps
--   spot? this could be useful for checking if you can switch the active pkmn. generally, you can't move around the team/bench/party. you delete and create instead.
--   major none|paralyze|burn|frozen|poison|faint
--   toactive() -- returns a new active pokemon, generated from this teampkmn.
-- }
---------------- these change
-- activepkmn { -- index metatable to teampkmn
--   set_minor() -- transform is number, mimic is number
--   getstat()
--   inc_stage()
--   stages -6 to 6 - accuracy, attack, defense, speed, special, evasion
--   accuracy -- 100
--   evasion  -- 100
--   last_used_move -- needed for mirrormove and mimic. defaults to nil.
--   turn_damage_taken -- defaults to 0. needed for counter. reset after each turn. this would be set in the "hurt" function. this is partly why we need a separate "hurt" and "heal" function.
--   -- get_valid_moves() -- if this is 0, that means you use struggle. otherwise, it will return between 1 to 4 move ids. it will not return moves if they have 0 pp or if you are in a multiturn move, or if it is disabled.
--   -- minor statuses
--   confused   -- affected by haze
--   disable_m  -- disable move
--   disable_t  -- disable o_timer
--   focused    -- affected by haze
--   misted     -- affected by haze
--   reflected  -- affected by haze
--   screened   -- affected by haze
--   seeded     -- affected by haze
--   toxiced    -- affected by haze
--   critmove   -- karatechop/slash/crabhammer/razorleaf
--   flinching  -- bite/boneclub/hyperfang/headbutt/stomp/lowkick/rollingkick -- resets at end of turn
--   substitute -- substitute
--   transform  -- transform - set, because you can't use transform once you are already transformed
--   digging    -- dig - uncontrollable + invincible (besides swift)
--   flying     -- fly - uncontrollable + invincible (besides swift)
--   preparing  -- skullbash/solarbeam/razorwind/skyattack - uncontrollable + next turn move
--   recharging -- hyperbeam - uncontrollable 1 turn
--   rage       -- rage                     - uncontrollable + use a move. attack increases each time you are hit, so no counter needed (use the stages counter)
--   thrashing  -- petaldance/thrash        - uncontrollable + use a move. has a o_timer (2-3 turns) and get confused at the end
--   trapping   -- bind/clamp/firespin/wrap - uncontrollable + use a move. is trapped? (o_timer 2-5 turns) recharging? preparing? thrashing?
--   trapped    -- if you are trapped in a bind/clamp/firespin/wrap
--   getmove(0-3), or get valid moves? ????

-- }
--------------- team (or player)... yes! i think...
-- team {
--   1-6 - each thing is a teampkmn
--   can_switch() -- give it an index, it tells you if you can switch with that pkmn
--   get_next()   -- returns the next party pokemon pokemon that 

--   hoard_index = 6 -- only used for hoard
--   active 
--   name=name1
--   priority=1
--   iscpu=iscpu1
--   actions={}
--   active=f_party_pkmn_to_active(f_get_next_active(party1))
--   party=party1
--   winlogic=p1_win_logic
--   dielogic=p1_die_logic
-- }

-- converts a party into a party ready for battle
|[f_get_fight_party]| function(party)
    local fightparty = {}

    -- TODO: optimize for tokens
    for i=1,6 do
        local cur = party[i]
        if cur then
            local pkmn = c_pokemon[cur.num]
            fightparty[i] = {
                -- todo, try just copying all keys from pkmn
                -- things that won't change
                num     = cur.num,
                lvl     = pkmn.level,
                maxhp   = pkmn.maxhp,
                attack  = pkmn.attack,
                defense = pkmn.defense,
                speed   = pkmn.speed,
                special = pkmn.special,
                moveids = (function() local m = {} for i=1,4 do m[i] = cur.moves[i] end return m end)(),

                -- things that can change
                hp      = pkmn.maxhp,
                movepps = (function() local m = {} for i=1,4 do m[i] = cur.moves[i] and c_moves[cur.moves[i]].pp end return m end)(),
            }
        end
    end

    return fightparty
end $$

-- partypkmn must be non-nil and match the party table structure defined in f_get_fight_party 
|[f_party_pkmn_to_active]| function(partypkmn)
    return {
        type1 = c_pokemon[partypkmn.num].type1,
        type2 = c_pokemon[partypkmn.num].type2,
        moveids = (function() local m = {} for i=1,4 do m[i] = partypkmn.moveids[i] end return m end)(),
        movepps = partypkmn.movepps,

        -- these always start at zero
        stages = f_zobj[[
            special,0,
            defense,0,
            attack,0,
            speed,0,
            accuracy,0,
            evasion,0
        ]],

        -- evasion and accuracy have a different formula: https://www.smogon.com/rb/articles/stadium_guide
        -- all stats cap at 999: https://www.smogon.com/rb/articles/rby_mechanics_guide
        -- and i'm giving it a _min of 1 too, because zero messes things up
        getstat = function(a, stat)
            local stage = a.stages[stat]
            return _ceil(_mid(1, 999,
                a.shared[stat]*(
                    (stat == 'evasion' or stat == 'accuracy')
                    and _mid(1, 1+stage/3, 3)/_mid(1, 1-stage/3, 3)
                     or _mid(2, 2+stage,   8)/_mid(2, 2-stage,   8)
                )
            ))
        end,

        minor = {},
        shared = partypkmn,
    }
end $$
