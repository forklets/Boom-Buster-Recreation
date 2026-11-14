if (instance_exists(obj_bonus_controller) && obj_bonus_controller.screen_results)
    exit;

if (instance_exists(obj_bom_explode_anim))
{
    if (obj_bom_explode_anim.my_bom == id)
        anim_logic();
    
    exit;
}

event_inherited();

if (keyboard_check_pressed(ord("Q")) && global.debug)
    timer[0] = 60;

if (exit_freeze() || inPipe || instance_exists(obj_player_death))
    exit;

get_cams(0);

if (x < (camx - 96) && global.auto_scroller && carried == noone)
    event_explode();

var _player = instance_place(x, y, obj_player);

if (_player && !tossed)
{
    if (global.powerup == 1)
    {
        event_grabbed(_player);
        landY = room_height + 999;
        tossed = true;
        landed = true;
        hammered = true;
        event_user(0);
        vspd -= 4;
        global.freeze = 2;
        screen_shake(10, 10);
        play_impact();
        var _dir;
        
        if (_player.x >= x)
            _dir = -1;
        else
            _dir = 1;
        
        var _y = y - 32;
        part_particles_create(global.part_over, _player.x + (30 * _dir), _y, global.particles.hitmarker, 1);
        
        with (obj_pipe)
        {
            if (col == other.col)
                other.my_pipe = id;
        }
    }
}

if (hammered)
    x = easy_smooth(x, my_pipe.x + 128, 6);

if (!tossed && !exit_freeze())
    timer_logic(0);

if (place_meeting(x, y, obj_killbom) && !on_path)
    event_explode();

if (omg)
{
    draw_xoff = choose(-2, 2);
    draw_yoff = choose(-2, 2);
}
