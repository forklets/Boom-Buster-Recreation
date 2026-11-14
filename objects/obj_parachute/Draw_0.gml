if (!ready)
    exit;

if (col == 4)
    pal_swap(pal_bom_yellow, 0, global.colorblind);

var _angle = sin((current_time / 280) + wave_offset) * 8;
draw_sprite_ext(anim_sprite, anim_index, x, y, 1, 1, _angle, c_white, 1);

if (col == 4)
    shader_reset();
