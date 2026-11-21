draw_set_font(obj_persistent.font_pixel_outline);
draw_set_halign(fa_center);
var _headers = ["ACT I: New York", "ACT II: Mall", "ACT III: Factory", "ACT IV: Outskirts", "BONUS"];

if (!array_contains(global.save.stages_beat, "rm_round_1"))
    _headers[0] = "ACT I: ???";

if (!array_contains(global.save.stages_beat, "rm_round_8"))
    _headers[1] = "ACT II: ???";

if (!array_contains(global.save.stages_beat, "rm_round_15"))
    _headers[2] = "ACT III: ???";

if (!array_contains(global.save.stages_beat, "rm_outskirts_1"))
    _headers[3] = "ACT IV: ???";

if (!array_contains(global.save.stages_beat, "rm_bonus_1"))
    _headers[4] = "???";

header = _headers[menu];
header = string_upper(header);
var _y = 85;
var _scale = 2.75;
draw_text_transformed(1445, _y, header, _scale, _scale, 0);
draw_set_halign(fa_left);
var _rounds = array_length(rounds);
var _sep = 52;
var _rad = 13;
var _w = (_rad * (_rounds - 1)) + (_sep * (_rounds - 2));
var _x = 1445 - (_w / 2);
_y += 80;

for (var i = 0; i < _rounds; i++)
{
    var __rad = _rad;

    if (menu == i)
        __rad += 8;

    draw_circle(_x, _y, __rad, false);
    _x += _sep;
}

_w = sprite_get_width(spr_ui_highscore);
_x = 970 + (_w / 2) + 18;
_y += 40;
_scale = 1.25;
draw_sprite_ext(spr_ui_highscore, 0, _x, _y, _scale * 0.94, _scale * 0.94, 0, c_white, 1);
draw_set_font(obj_persistent.font_alarm);
draw_set_color(make_colour_hsv(0, 255, 240));
var _dollars = round_dollars;
_x += 168;
_y += 31;
_scale *= 0.84;
var _xscale = 1;
var _angle = 0;

if (round_dollars <= 0)
    draw_set_color(make_colour_hsv(0, 255, 170));

draw_text_transformed(_x, _y - 2, string_add_zeros(_dollars, 3, 2), _xscale * _scale * 0.94, _scale * 0.94, _angle);
draw_set_color(c_white);
draw_set_font(obj_persistent.font_pixel);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
_x = 1459;
_y += 150;
_sep = 83;
_scale = 2.5;
var _food_scale = 0.95;
var _food_sep = 305;
var _foodsA = [rm_round_1, rm_round_2, rm_round_3, rm_round_4, rm_round_5, rm_round_6, rm_round_8, rm_round_9, rm_round_10, rm_mall_extra1, rm_round_11, rm_round_12, rm_round_13, rm_round_15, rm_round_16, rm_round_17, rm_factory_extra1, rm_round_18, rm_round_19, rm_round_20, rm_outskirts_1, rm_outskirts_2, rm_outskirts_3];
var _foodsB = [rm_round_b1, rm_round_b2, rm_round_b3, rm_round_b4, rm_round_b5, rm_round_b6, rm_round_b8, rm_round_b9, rm_round_b10, rm_mall_extrab1, rm_round_b11, rm_round_b12, rm_round_b13, rm_round_b15, rm_round_b16, rm_round_b17, rm_factory_extrab1, rm_round_b18, rm_round_b19, rm_round_b20, rm_outskirts_b1, rm_outskirts_b2, rm_outskirts_b3];

for (var i = 0; i < array_length(rounds[menu]); i++)
{
    var _room = rounds[menu][i][global.bside];
    var _highscore;

    if (struct_exists(global.save.round_highscores, room_get_name(_room)))
        _highscore = variable_struct_get(global.save.round_highscores, room_get_name(_room));
    else
        _highscore = 0;

    var _quota = 999999;

    if (struct_exists(global.round_quotas, room_get_name(_room)))
        _quota = variable_struct_get(global.round_quotas, room_get_name(_room));

    if (selected[menu] == i)
        round_dollars = _highscore;

    var _bar_scale;

    if (selected[menu] == i)
        _bar_scale = 1.1;
    else
        _bar_scale = 1;

    draw_sprite_ext(spr_paused_bar, 0, _x, _y, 0.9 * _bar_scale, _bar_scale, 0, c_white, 1);

    if (selected[menu] != i)
        draw_sprite_ext(spr_paused_bar, 0, _x, _y, 0.9 * _bar_scale, _bar_scale, 0, c_black, 0.15);

    var _foods;

    if (global.bside)
        _foods = _foodsB;
    else
        _foods = _foodsA;

    if (array_contains(_foods, _room))
    {
        if (menu == (array_length(rounds) - 1))
        {
        }
        else if (array_contains(global.save.round_foods, room_get_name(_room)))
            draw_sprite_ext(spr_food, 0, _x + _food_sep, _y, _food_scale, _food_scale, 0, c_white, 1);
    }

    if (selected[menu] == i)
        _scale = 2.5;

    var _me = rounds[menu][i][global.bside];
    var _label = "ROUND";
    var _round;

    if (menu == (array_length(rounds) - 1))
    {
        _label = "BONUS";
        _round = scr_get_bonus(_me);
    }
    else
        _round = scr_get_round(_me);

    var _str;

    if (array_contains(global.save.stages_beat, room_get_name(_room)))
    {
        if (_room == rm_final_scroll || (_room == rm_final_scroll_b && array_contains(global.save.stages_beat, room_get_name(_room))))
        {
            _str = "FINALE";

            if (global.bside)
                _str += " B";
        }
        else
        {
            _str = $"{_label} {_round + 1}";

            if (global.bside)
                _str += "B";
        }
    }
    else
        _str = "???";

    if (global.debug && keyboard_check(vk_control))
    {
        _str = room_get_name(_room);
        _str = string_upper(_str);
    }

    if (global.debug && keyboard_check(vk_tab))
    {
        _str = _quota;
        _str = string_upper(_str);
    }

    draw_text_transformed(_x, _y + 6, _str, _scale * _bar_scale * 0.95, _scale * _bar_scale * 0.95, 0);

    if (selected[menu] != i)
        draw_sprite_ext(spr_paused_bar, 0, _x, _y, 0.9 * _bar_scale, _bar_scale, 0, c_black, 0.3);

    _y += _sep;
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);

if (!global.save.campaign_beat_A)
    exit;

_scale = 2.5;
_x = 1100;
_y = 925;
_y = 132;
_x += 578;
_y += 95;
var _amnt = 8;
var _shakeX = irandom_range(-_amnt, _amnt) * bar_shake;
var _shakeY = irandom_range(-_amnt, _amnt) * bar_shake;
glyph_shakeX = _shakeX;
glyph_shakeY = _shakeY;
_x += glyph_shakeX;
_y += glyph_shakeY;
draw_glyph(global.input_menu_special_glyph, _x, _y, 1, 1);
draw_set_font(obj_persistent.font_pixel);
_x = 1747;
_y = 211;
_x += glyph_shakeX;
_y += glyph_shakeY;
draw_sprite(spr_title_charswap, global.player_character[0], _x, _y);
