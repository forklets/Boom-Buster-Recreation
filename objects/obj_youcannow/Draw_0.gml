y = 540 - (sprite_get_height(spr_youcannow) / 2);
draw_sprite_ext(spr_youcannow, 0, x, y, 1, 1, 0, c_white, alpha);
draw_set_alpha(alpha);
var _xoff, _yoff, _scale;

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

draw_glyph("Z", x + 1134 + _xoff, y + 77 + _yoff, _scale, alpha);
draw_set_alpha(1);
