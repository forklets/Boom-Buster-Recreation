var _a = draw_get_halign();
draw_set_halign(fa_center);
draw_set_font(obj_persistent.font_pixel_outline);
var _p1 = $"{player[0].device_name}";
var _p2 = $"{player[1].device_name}  ";
var _drawX = 960;

if (instance_exists(obj_paused))
    _drawX = global.app_xoff + 704;

var _col = draw_get_colour();
var _buster = 
{
    name: "BUSTER",
    col: 1335295
};
var _bridget = 
{
    name: "BRIDGET",
    col: 13161501
};
var _p1_data = _buster;
var _p2_data = _bridget;

if (global.player_character[0] == 1)
{
    _p1_data = _bridget;
    _p2_data = _buster;
}

draw_set_colour(_p1_data.col);
draw_text_shake(_drawX, 375, $"{_p1_data.name} (PLAYER 1):   ", 0, 3, 3);
draw_set_colour(c_white);

if (state >= 1)
    draw_set_colour(c_lime);
else
    draw_set_colour(c_white);

draw_text_shake(_drawX, 450, string_upper(_p1), 0, 3, 3);

if (state >= 2)
    draw_set_colour(c_lime);
else
    draw_set_colour(c_white);

draw_text_shake(_drawX, 705, string_upper(_p2), 0, 3, 3);
draw_set_colour(c_white);
draw_set_color(_p2_data.col);
draw_text_shake(_drawX, 630, $"{_p2_data.name} (PLAYER 2):   ", 0, 3, 3);
draw_set_color(c_white);
draw_set_colour(_col);
draw_set_halign(_a);

if (fade >= 1)
{
    var _alpha = draw_get_alpha();
    var _c = draw_get_colour();
    draw_set_alpha(clamp(fade - 1, 0, 1) * 2);
    draw_set_colour(c_black);
    draw_rectangle(0, 0, 1920, 1080, false);
    draw_set_alpha(_alpha);
    draw_set_colour(_c);
}
