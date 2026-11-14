var _x;

if (in_tutorial)
{
    _x = 704;
    var _y = y + (sin(current_time / 300) * 3);
    var _spr = spr_tutorial_clear;
    draw_sprite_ext(_spr, 0, _x, _y, 1, 1, 0, c_white, 1);
    var _alpha = use_curve(acurv_basics, percent_checkmark, "ease_out", 0, 1);
    _scale = use_curve(acurv_basics, percent_checkmark, "ease_out", 2, 1);
    draw_sprite_ext(_spr, 1, _x, _y, _scale, _scale, 0, c_white, _alpha);
}
else
{
    var _spr;
    
    if (obj_controller.stage_event == "wizard" && !array_contains(global.stages_outskirts, room))
        _spr = spr_boss_clear;
    else
        _spr = spr_round_clear;
    
    _w = sprite_get_width(_spr);
    
    if (array_contains(global.stages_final, room))
        _x = 960 - (_w / 2);
    else
        _x = 704 - (_w / 2);
    
    var _y = y;
    
    for (var i = 0; i < sprite_get_number(_spr); i++)
    {
        var _hue = (hue + 1 + (i * 20)) % 255;
        var _col = make_colour_hsv(_hue, 112, 255);
        draw_set_color(_col);
        var _yoff = sin((current_time / 115) + (i * pi * 0.3)) * 6;
        draw_sprite_ext(_spr, i, _x, _y + _yoff, 1, 1, 0, _col, 1);
    }
    
    draw_set_color(c_white);
}

draw_set_font(obj_persistent.font_pixel_outline);
var _scale = 2.8;
var _str = string_upper(msg);
var _w = string_width(_str) * _scale;

if (array_contains(global.stages_final, room))
    _x = 960 - (_w / 2);
else
    _x = 704 - (_w / 2);

draw_set_color(c_black);
draw_text_transformed((_x + slide_x) - 2, y + 236 + 2, _str, _scale, _scale, 0);
draw_set_color(c_white);
draw_text_transformed(_x + slide_x, y + 236, _str, _scale, _scale, 0);
