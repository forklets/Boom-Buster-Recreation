event_inherited();

if (exit_freeze())
    exit;

timer_logic(0);

if (!go)
    exit;

spd = easy_smooth(spd, 5, 15);

if (instance_exists(obj_player))
{
    if (point_distance(x, y, obj_player.x, obj_player.y) >= 128)
    {
        var _spd = spd;
        var _angle = point_direction(x, y, obj_player.x, obj_player.y - 64);
        hspd = dsin(_angle + 90) * _spd;
        vspd = dcos(_angle + 90) * _spd;
        
        if (hspd > 0)
            facing = 1;
        
        if (hspd < 0)
            facing = -1;
        
        if (facing == -1)
            angle = _angle + 180;
        else
            angle = _angle;
    }
}
else
{
    hspd = 0;
    vspd = 0;
}

if (hspd > 0)
    facing = 1;

if (hspd < 0)
    facing = -1;
