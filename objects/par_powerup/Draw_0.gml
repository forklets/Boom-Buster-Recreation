if (float_anim)
    float_y = sin(time) * 4;
else
    float_y = 0;

time += 0.1;
draw_sprite_ext(anim_sprite, anim_index, x, y + float_y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
