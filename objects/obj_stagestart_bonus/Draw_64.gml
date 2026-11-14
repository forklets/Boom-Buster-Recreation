if (go > 3)
    exit;

if (global.round_select && go > 0)
    exit;

var _str = string(go);

if (go == 0)
    _str = "GO!";

if (go < 0)
    _str = "";

draw_set_font(obj_persistent.font_pixel_outline);
var _x = 960;
var _y = 540;
var _scale = 5.5 * go_scale;
draw_set_alpha(go_alpha);

if (go == 0)
{
    _x += choose(-1, -2, 1, 2);
    _y += choose(-1, -2, 1, 2);
}

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_transformed(_x, _y, _str, _scale, _scale, 0);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_alpha(1);
