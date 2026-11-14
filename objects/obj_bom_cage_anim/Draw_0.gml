var _x = x;
var _y = y;
var _flash = false;

if (state == 2)
{
    _x += choose(-3, 3);
    _x += choose(-3, 3);
    _flash = floor((current_time / 50) % 2) == 0;
}

var _xscale = xscale;
var _yscale = yscale;
var _facing = 1;
var _yoff = 0;

if (anim_sprite == spr_bom_cage_bounce)
{
    if (bounces == 1 && anim_index < (sprite_get_number(anim_sprite) - 1))
        _facing = -1;
}

if (bounce_state == 0)
    _yoff += (40 * (yscale - 1));

pal_swap(pal_bom_cage, global.colorblind, col + 1);
draw_sprite_ext(anim_sprite, anim_index, x, y + yoff + _yoff, 1.1 * _xscale * _facing, 1.1 * _yscale, angle, c_white, 1);

if (eyes_sprite != noone)
    draw_sprite_ext(eyes_sprite, eyes_index, x, y + yoff, 1.1 * _xscale, 1.1 * _yscale, angle, c_white, 1);

shader_reset();

if (flash != 0)
{
    shader_set(sha_flash);
    draw_sprite_ext(anim_sprite, anim_index, x, y + yoff + _yoff, 1.1 * _xscale * _facing, 1.1 * _yscale, angle, c_white, flash * 0.5);
    shader_reset();
}
