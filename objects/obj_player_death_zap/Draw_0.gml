if (fire && !create_smoke)
{
    var _spr = spr_death_fire;
    
    if (lava)
        _spr = spr_death_fire_lava;
    
    draw_sprite_ext(_spr, anim_index, x, y, facing, 1, 0, c_white, 1);
}

if (fire)
{
    var _pal;
    
    if (global.player_character[player] == 0)
        _pal = pal_buster;
    else
        _pal = pal_bridget;
    
    pal_swap(_pal, 0, global.palette[global.player_character[player]] + 1);
}

draw_sprite_ext(anim_sprite, anim_index, x, y, facing, 1, 0, c_white, 1);
shader_reset();
