if (!ready)
    exit;

draw_set_alpha(image_alpha);
get_cams();
draw_set_font(obj_persistent.font_pixel_outline);
var _x = camx + 704;
var _y = camy + 24;
var _scale = 2.2;
var _sep = 26 * _scale;
scr_text_custom_draw(_x, _y, text_draw, _scale, _sep);
draw_set_alpha(1);
