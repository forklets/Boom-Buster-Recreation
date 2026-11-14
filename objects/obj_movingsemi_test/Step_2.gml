if (exit_freeze() || !ready)
    exit;

move[0] = hspd;
move[1] = vspd;

for (var c = 0; c < 2; c++)
{
    move_sub[c] += move[c];
    move_calc[c] = round(move_sub[c]);
    move_sub[c] -= move_calc[c];
}

collision_rectangle_list(bbox_left - 100, bbox_top - 100, bbox_right + 100, bbox_bottom + 100, par_physics, false, true, list_push, true);
stop = false;

repeat (abs(move_calc[0]))
{
    for (var i = 0; i < ds_list_size(list_push); i++)
    {
        with (ds_list_find_value(list_push, i))
        {
            if (has_collision && place_meeting(x, y + 1, other) && y <= other.y && !place_meeting(x + other.move_calc[0], y, obj_solid) && !on_wall(sign(other.move_calc[0])))
                x += sign(other.move_calc[0]);
        }
    }
    
    x += sign(move_calc[0]);
}

repeat (abs(move_calc[1]))
{
    var _stop = false;
    
    for (var i = 0; i < ds_list_size(list_push); i++)
    {
        with (ds_list_find_value(list_push, i))
        {
            if (has_collision && place_meeting(x, y + 1, other) && y <= (other.y + 1))
            {
                var _ground_under = false;
                y = other.y;
                var _array = instance_place_array(x, y + 1, par_ground);
                
                for (var ii = 0; ii < array_length(_array); ii++)
                {
                    if (_array[ii] != other.id)
                        _ground_under = true;
                }
                
                if (other.move_calc[1] < 0 && solid_meeting(x, y - 1, obj_solid))
                    _stop = true;
                else if (!(other.move_calc[1] > 0 && _ground_under))
                    y += sign(other.move_calc[1]);
            }
        }
    }
    
    if (_stop)
    {
        stop = true;
        
        if (mypath == noone)
            move[1] = -move[1];
        else
            move[1] = 0;
        
        break;
    }
    
    stop = false;
    y += sign(move_calc[1]);
}

if (stop)
    stop_path_ease = 0;

stop_path = stop;
ds_list_clear(list_push);
