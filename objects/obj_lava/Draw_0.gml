var _yscale = 1.1 + (sin(current_time / 500) * 0.1);
draw_sprite_ext(spr_lava_gradient, 0, x, (y - 32) + 143 + 16, image_xscale, _yscale, 0, c_white, 0.8);

for (var i = 0; i < image_xscale; i++)
{
    draw_sprite_ext(spr_lava_top, anim_index, x + (i * 64), y, 1, 1, 0, c_white, image_alpha);
    
    for (var j = 1; j < 24; j++)
    {
        var _spr;
        
        if (j == 1)
            _spr = spr_lava_bottom;
        else
            _spr = spr_lava_bottom_deep;
        
        draw_sprite_ext(_spr, anim_index, x + (i * 64), y + (j * 64), 1, 1, 0, c_white, image_alpha);
    }
}
