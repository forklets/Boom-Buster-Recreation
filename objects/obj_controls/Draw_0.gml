if (gui || !ready)
    exit;

get_cams();
var _x = x + (camx * dist);
var _y = y + (camy * dist);

if (special != noone)
{
    var _scale = 1;
    draw_sprite_ext(special, swap, _x, _y, image_xscale * _scale, image_yscale * _scale, image_angle, image_blend, image_alpha);
    exit;
}
