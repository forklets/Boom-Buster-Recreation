if (wings)
{
    draw_sprite(spr_wing, wing_ind, x - wing_width, y + wing_yoff + wings_sin + pipe_ysin);
    draw_sprite_ext(spr_wing, wing_ind, x + wing_width, y + wing_yoff + wings_sin + pipe_ysin, -1, 1, 0, c_white, 1);
}

if ((object_index == obj_bom || object_index == obj_bom_fat) && col == 4)
    pal_swap(pal_bom_yellow, 0, global.colorblind);
else if (pal_sprite != noone)
    pal_swap(pal_sprite, global.colorblind, pal_ind);

draw_me();

if (pal_sprite != noone)
    shader_reset();

shader_set(sha_flash);
draw_me(65280, flash_nuclear_alpha);
shader_reset();
