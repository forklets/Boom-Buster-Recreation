for (var i = 0; i < image_xscale; i++)
{
    var _spr;
    
    if ((i % 2) == 0)
        _spr = anim_sprite;
    else if (anim_sprite == spr_barbedwire_0)
        _spr = spr_barbedwire_1;
    else if (anim_sprite == spr_barbedwire_0_active)
        _spr = spr_barbedwire_1_active;
    
    draw_sprite(_spr, anim_index, x + (64 * i), y);
}
