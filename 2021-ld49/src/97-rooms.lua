-- room resec helper functions and functions
function get_all_enemies_for_story_mode()
    return {
        dungeon=ztable[[
            x=4  , y=28, func=%nurse, alive=yes;
            x=14 , y=26, func=%nurse, alive=yes;
            x=45 , y=28, func=%nurse, alive=yes;
            x=53 , y=9 , func=%nurse, alive=yes;
            x=70 , y=13, func=%nurse, alive=yes;
            x=60 , y=15, func=%nurse, alive=yes;
            x=48 , y=3 , func=%nurse, alive=yes;
            x=81 , y=4 , func=%nurse, alive=yes;
            x=81 , y=15, func=%nurse, alive=yes;
            x=18 , y=13, func=%nurse, alive=yes;
            x=102, y=4 , func=%nurse, alive=yes;
        ]], bossroom=ztable[[
            x=120, y=12, func=%pl_monster_cpu, alive=yes;
        ]]
    }
end

-- draws the hearts at the top of the screen, with particles!
function create_ui_hearts()
    _g.heart_particle_spawner(6.5, 1, 3)
    _g.heart_particle_spawner(9.5, 1, 2)
    _g.heart_particle_spawner(  8, 1, 1)
end

-- the emotion faces things
function create_ui_powerups()
    _g.powerup_particle_spawner(3 , 1 , 0, _g.c_color_normal  , 72)
    _g.powerup_particle_spawner(4 , 15, 1, _g.c_color_insane_1, 74)
    _g.powerup_particle_spawner(8 , 15, 2, _g.c_color_insane_2, 76)
    _g.powerup_particle_spawner(12, 15, 3, _g.c_color_insane_3, 78)
    _g.powerup_particle_spawner(13, 1 , 4, _g.c_color_angry   , 104)
end

function create_all_enemies()
    for i, enemy_template in pairs(_g.all_enemy_templates[g_room.name]) do
        if enemy_template.alive then
            enemy_template.func(enemy_template.x, enemy_template.y, i)
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
    g_pl = _g.pl_monster_control(94, 11)
    g_view = _g.view(15.25, 11.5, 3, g_pl)
    g_room = ztable[[ name:dungeon; x:0; y:0; w:108; h:32; ]]

    _g.portal(94, 13)
    create_all_deadbodies()
    create_all_enemies()
    create_ui_hearts()
    create_ui_powerups()

    _g.genocide_tip(8, 13)
end

-- resets the boss room
function reset_the_bossroom()
    cleanup_confined()

    _g.fader_in(.5, nf, nf)
    g_pl   = _g.pl_patient_control_fight(118, 27)
    g_view = _g.view(15.25, 11.5, 3, g_pl)
    g_room = ztable[[ name:bossroom; x:108; y:0; w:20; h:32; ]]

    create_all_deadbodies()
    create_all_enemies()

    create_ui_hearts()
end
