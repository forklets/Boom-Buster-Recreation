for (var i = 0; i < array_length(debris); i++)
{
    var _d = debris[i];
    draw_sprite_ext(spr_tower_wall_shards, _d.frame, _d.x, y + _d.y, _d.scale, _d.scale, _d.angle, c_white, 1);
    draw_sprite_ext(spr_tower_wall_shards, _d.frame, _d.x, y + _d.y, _d.scale, _d.scale, _d.angle, c_black, 0.35);
    
    if (!exit_freeze())
    {
        _d.y += _d.vspd;
        _d.vspd += _d.grav;
        _d.angle += _d.dir;
        _d.life++;
        
        if (_d.life > 240)
            array_delete(debris, i, 1);
    }
}
