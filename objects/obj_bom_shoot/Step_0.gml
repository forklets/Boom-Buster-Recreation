anim_logic();
sprite_index = anim_sprite;
image_index = anim_index;

if (y < -140 && vspd < 0)
{
    if (instance_exists(obj_tower))
    {
        var _sep = 110;
        x = irandom_range(obj_tower.x - _sep, obj_tower.x + _sep);
        vspd = 12.5;
    }
    else
    {
        event_explode();
    }
}

if (vspd > 0)
{
    if (y > (obj_tower.y + obj_tower.y_sink + tower_offset))
        event_explode();
    
    vspd += 0.05;
}

y += vspd;
