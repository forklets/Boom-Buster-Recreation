if (!gui || !ready)
    exit;

var _x;

if (surface_get_width(application_surface) == 1920)
    _x = x;
else
    _x = x + global.app_xoff;

var _y = y;

if (special != noone)
{
    draw_sprite_ext(special, swap, _x, _y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
    exit;
}
