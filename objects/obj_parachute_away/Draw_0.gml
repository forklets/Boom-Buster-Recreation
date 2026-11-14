if (col != undefined)
    pal_swap(pal_chute, global.colorblind, col);

var _angle = sin((current_time / 280) + wave_offset) * 8;
draw_sprite_ext(anim_sprite, 0, x, y, 1, 1, _angle, c_white, 1);

if (col != undefined)
    shader_reset();
