var _yoff = 100;
var _scale = 2.5;
draw_set_font(obj_persistent.font_pixel);
draw_set_halign(fa_center);
draw_text_transformed(960, 80 + _yoff, "B-SIDE UNLOCKED:", _scale, _scale, 0);
draw_set_halign(fa_left);
x = 960;
y = (540 - (sprite_get_height(spr_youcannow) / 2)) + _yoff;
draw_sprite_ext(spr_wizardsrevenge, 0, x, y, 1, 1, 0, c_white, 1);
draw_set_alpha(alpha);
var _xoff;

if (glyph_scale_num == 1)
{
    _scale = 0.9;
    _xoff = 4;
    _yoff = 4;
}
else
{
    _scale = 1;
    _xoff = 0;
    _yoff = 0;
}

var _x = 1800;
var _y = 990;
draw_glyph("Z", _x + _xoff, _y + _yoff, _scale, alpha);
draw_set_alpha(1);
