-- room resec helper functions and functions
function get_all_enemies_for_story_mode()
    local dungeon_and_hospital = tabcpy(ztable[[
        x=5,  y=5, dungeon=%bad_police, hospital=%police, alive=yes;
        x=41, y=18, dungeon=%bad_police, hospital=%police, alive=yes;
    ]])

    return {
        dungeon=dungeon_and_hospital,
        hospital=dungeon_and_hospital,
        bossroom=tabcpy(ztable[[
            x=126, y=8, bossroom=%pl_monster_cpu, alive=yes;
        ]])
    }
end

-- turns every tile in the map to a hospital tile.
function hospitalify_the_map()
    for x=0,107 do
        for y=0,31 do
            local v = mget(x, y)
            if v >= 1 and v <= 4 then v += 4
            elseif v >= 17 and v <= 20 then v += 4
            elseif v >= 33 and v <= 36 then v += 4
            elseif v >= 49 and v <= 52 then v += 4
            elseif v == 32 or v == 46 or v == 47 then v += 16
            elseif v == 117 then v += 1
            end
            mset(x, y, v)
        end
    end
end

-- draws the hearts at the top of the screen, with particles!
function create_ui_hearts()
    _g.heart_particle_spawner(6.5, 1, 3)
    _g.heart_particle_spawner(9.5, 1, 2)
    _g.heart_particle_spawner(  8, 1, 1)
end

function create_all_enemies()
    for i, enemy_template in pairs(_g.all_enemy_templates[g_room.name]) do
        if enemy_template.alive then
            enemy_template[g_room.name](enemy_template.x, enemy_template.y, i)
        end
    end
end

function create_all_deadbodies()
    for body in all(_g.all_deadbody_templates[g_room.name]) do
        _g.deadbody_nobleed(unpack(body))
    end
end

function cleanup_confined()
    batch_call_new(acts_loop, [[
        confined,room_end;
        confined,kill;
        confined,delete;
    ]])
end

-- resets the non-hospital dungeon
function reset_the_dungeon()
    cleanup_confined()

    _g.fader_in(.5, nf, nf)
    g_pl = _g.pl_monster_control(18, 3)
    g_view = _g.view(15.25, 11.5, 3, g_pl)
    g_room = ztable[[ name:dungeon; x:0; y:0; w:108; h:32; ]]

    _g.portal(94, 13)
    create_all_deadbodies()
    create_all_enemies()
    create_ui_hearts()
    _g.objective_arrow(8, 13)
end

-- resets the hospital
function reset_the_hospital()
    hospitalify_the_map()
    cleanup_confined()

    _g.fader_in(.5, nf, nf)
    _g.portal(18, 3)
    g_pl = _g.pl_patient_control_passive(94, 13)
    g_view = _g.view(15.25, 11.5, 3, g_pl)
    g_room = ztable[[ name:hospital; x:0; y:0; w:108; h:32; ]]

    create_all_deadbodies()
    create_all_enemies()
    create_ui_hearts()
    _g.objective_arrow(8, 13)
end

-- resets the boss room
function reset_the_bossroom()
    cleanup_confined()

    _g.fader_in(.5, nf, nf)
    g_pl   = _g.pl_patient_control_fight(110, 8)
    g_view = _g.view(15.25, 11.5, 3, g_pl)
    g_room = ztable[[ name:bossroom; x:108; y:0; w:20; h:16; ]]

    create_all_deadbodies()
    create_all_enemies()

    create_ui_hearts()
    _g.objective_arrow(8, 13)
end
