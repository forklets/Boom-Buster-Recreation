if (exit_freeze() && path_lock_timer == -1)
    exit;

if (path_lock_timer > -1)
    path_lock_timer--;

if (((place_meeting(x, y + 1, obj_spike) && dies_on_spikes) || place_meeting(x, y, obj_buzzsaw)) && !instance_exists(obj_player_death))
{
    event_user(3);
    exit;
}

var _player = instance_place(x, y - 1, par_player);

if (vspd == 0 && _player)
{
    with (_player)
    {
        var _enemy = instance_place(x, y + 1, par_enemy);
        
        if (vspd == 0 && _enemy && _enemy.stompable && y <= (_enemy.bbox_top + 4))
        {
            with (_enemy)
            {
                hitBy = other;
                hurt_delay = 10;
                event_user(0);
            }
            
            while (place_meeting(x, y + 10, _enemy))
                y--;
            
            event_bounce_enemy();
        }
    }
}

if (mypath != noone)
{
    on_path = true;
    has_collision = false;
}

path_follow();

if (ledge_turn && on_ground() && !place_meeting(x + hspd, y + 4, [par_ground, obj_movingsemi]) && !place_meeting(x, y + 1, obj_conveyor_semi) && !place_meeting(x, y + 1, obj_conveyor))
    event_wall();

physics_apply();

if (vspd > vspd_max)
    vspd = vspd_max;

if (y > (room_height + 250))
    instance_destroy();
