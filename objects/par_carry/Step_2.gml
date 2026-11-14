if (inPipe)
    exit;

if (exit_freeze())
    exit;

if (instance_exists(obj_player_death) && tossed)
    exit;

if (instance_exists(carried))
    event_user(2);

xscale_squish = approach(xscale_squish, 1, 0.1);
yscale_squish = approach(yscale_squish, 1, 0.1);

if (carried != noone && !instance_exists(carried))
    carried = noone;

if (instance_exists(carried))
{
    player = carried.player;
    
    if (throwable)
        facing = carried.facing;
    
    var _pos = ds_list_find_index(carried.list_carry, id);
    var _pos_yoff = 0;
    
    for (var i = 0; i < _pos; i++)
    {
        var _val = ds_list_find_value(carried.list_carry, i);
        
        if (_val.object_index == obj_bom_fat)
            _pos_yoff -= 55;
        
        if (_val.object_index == obj_bom_swap)
            _pos_yoff -= 20;
    }
    
    if (throw_now)
    {
        if (carried.anim_index < 1)
        {
            x = carried.x - (89 * carried.facing);
            y = (carried.y - 49 - (55 * _pos)) + _pos_yoff;
        }
        else if (carried.anim_index < 2)
        {
            x = carried.x + (40 * carried.facing);
            y = (carried.y - 49 - (55 * _pos)) + _pos_yoff;
        }
        else
        {
            if (solid_meeting(x, y, obj_solid))
            {
                while (solid_meeting(x, y, obj_solid))
                {
                    x -= throw_facing;
                    
                    if (!solid_meeting(x, y, obj_solid))
                        break;
                }
            }
            
            ds_list_delete(carried.list_carry, ds_list_find_index(carried.list_carry, id));
            thrown = true;
            hspd = facing * 20;
            vspd = 0;
            grav = 0;
            timer[1] = throw_grav_delay;
            ignore = carried;
            ignore_timer = 20;
            carried = noone;
        }
    }
    else
    {
        var _yoff;
        
        if (carried.state == carried.state_cannon && !carried.cannon_shot)
            _yoff = 20;
        else
            _yoff = 0;
        
        var _hspd = clamp(carried.hspd, -15, 15);
        var _xoff_to = _hspd * my_index * 0.625;
        xoff = easy_smooth(xoff, _xoff_to, 3);
        x = carried.x - xoff;
        var _charyoff = 0;
        
        if (carried.char == 1)
            _charyoff = -12;
        
        y = (carried.y - 103 - (55 * _pos)) + _yoff + _pos_yoff + fall_yoff + bounce_yoff + _charyoff;
    }
    
    carry_yoff = approach(carry_yoff, 0, 4);
}
else
{
    carry_yoff = 0;
}

if (global.auto_scroller && tossed && !hammered)
{
    get_cams(0);
    x = camx + tossed_cam_xdiff;
}
