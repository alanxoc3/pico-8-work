-- lr is guaranteed to be -1 or 1
|[f_browsestat_lrfunc]| function(_ENV, lr)
    local stayed = true
    for i=browse.menu.c+lr,75.5+75.5*lr,lr do
        if c_pokemon[i]:available() then
            browse.menu.c = i
            stayed = false
            f_minisfx'B_BACK'
            break
        end
    end

    if stayed then f_beep() end
    f_browsestat_init(_ENV)
end $$

-- lr is guaranteed to be -1 or 1
|[f_pstat_lrfunc]| function(_ENV)
    p0.statplayer = f_get_other_pl(_ENV, p0.statplayer)
    f_minisfx'B_BACK'
    f_pstat_init(_ENV)
end $$

|[f_pstat_xfunc]|      function(_ENV) f_minisfx(p0.statplayer.active.num) end $$ 
|[f_browsestat_xfunc]| function(game) f_minisfx(game:cursor'browse')      end $$ 
|[f_credits_xfunc]|    function()     f_minisfx(f_flr_rnd'152')           end $$
|[f_fightover_xfunc]|  function(_ENV) f_minisfx(p0.active.num)            end $$
