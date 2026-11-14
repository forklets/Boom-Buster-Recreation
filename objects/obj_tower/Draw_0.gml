if (array_contains(global.stages_final_scroll, room))
{
    draw_sprite_ext(spr_tower, 0, xstart, ystart, image_xscale, image_yscale, 0, c_white, 1);
    shader_set(sha_flash);
    draw_sprite_ext(spr_tower, 0, xstart, ystart, image_xscale, image_yscale, 0, c_white, 0.2);
    shader_reset();
}
