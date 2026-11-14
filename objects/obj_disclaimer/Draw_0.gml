hue += 1.5;
draw_set_font(fnt_comicsans);
var _str = "DID YOU KNOW?";
var _x = 960;
var _y = 200;
var _scale = 0.55;
var _xx = _x - ((string_width(_str) * _scale) / 2);
var _yy = _y;

for (var i = 0; i < sprite_get_number(spr_pickdat); i++)
{
    var _hue = (hue + 1 + (i * 20)) % 255;
    var _col = make_colour_hsv(_hue, 112, 255);
    var _yoff = sin((current_time / 150) + (i * pi * 0.15)) * 3;
    draw_set_color(_col);
    var _chr = string_char_at(_str, i + 1);
    draw_text_transformed(_xx, _yy + _yoff, _chr, _scale, _scale, 0);
    _xx += (string_width(_chr) * _scale);
    draw_set_color(c_white);
}

_x = 960;
_y = 610;
_scale = 2.5;
_str = splash;
_str = string_upper(_str);
draw_set_font(obj_persistent.font_pixel);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_ext_transformed(_x, _y, _str, 30, 600, _scale, _scale, 0);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
