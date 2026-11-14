if (pal_sprite != noone)
    pal_swap(pal_sprite, pal_sub, pal_ind);

draw_sprite_ext(anim_sprite, anim_index, x, y - (8 * yscale), 1 + xscale, 1 + yscale, 0, c_white, 1);

if (pal_sprite != noone)
    shader_reset();

if (screen_spr != noone)
    draw_sprite_ext(screen_spr, anim_index, x, y - (8 * yscale), 1 + xscale, 1 + yscale, 0, c_white, 1);
