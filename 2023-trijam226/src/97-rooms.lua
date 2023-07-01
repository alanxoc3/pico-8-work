-- room resec helper functions and functions
function get_all_enemies_for_story_mode()
    local dungeon_and_hospital = tabcpy(ztable[[
        x=5,  y=5, dungeon=%bad_police, hospital=%police, alive=yes;
    ]])

    return {
        dungeon=dungeon_and_hospital,
        hospital=dungeon_and_hospital,
        bossroom=tabcpy(ztable[[
            x=126, y=8, bossroom=%pl_monster_cpu, alive=yes;
        ]])
    }
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

    -- _g.portal(94, 13)
    create_all_deadbodies()
    create_all_enemies()
    create_ui_hearts()
    g_objective_arrow = _g.objective_arrow(8, 13)
    _g.statsels()
end
