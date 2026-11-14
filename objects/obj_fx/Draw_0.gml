if (bm != 0)
    gpu_set_blendmode(bm);

if (pal_sprite != noone)
    pal_swap(pal_sprite, pal_sub, pal_ind);

draw_sprite_ext(anim_sprite, anim_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

if (pal_sprite != noone)
    shader_reset();

if (bm != 0)
    gpu_set_blendmode(bm_normal);
