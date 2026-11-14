if (frame == -1)
    exit;

pal_swap(pal_buster, 0, 1);
draw_sprite_ext(anim_sprite, anim_index, x, y, facing * xscale_squish, yscale_squish, 0, c_white, 0.4 * image_alpha);
shader_reset();
