if (!surface_exists(surf))
    surf = surface_create(1920, 1080);

surface_set_target(surf);
draw_clear_alpha(c_white, 0);
draw_sprite_tiled(spr_results_bg, 1, bg_pos, bg_pos * 0.5);
draw_set_font(obj_persistent.font_pixel_gradient);
draw_set_halign(fa_center);
pal_swap(pal_font_gradient, 0, 1);
var _x = 960;
var _y = 100;
var _scale = 3;
shader_reset();
draw_set_halign(fa_left);
var _player_yoff, _glyph;

if (room == rm_title && global.save.campaign_beat_A)
{
    _glyph = true;
    _player_yoff = 0;
}
else
{
    _glyph = false;
    _player_yoff = 15;
}

_x = 475;
_y = 640;
_scale = 2.5;
var _pal, _char, _spr, _ind, _idle;

if (global.player_character[0] == 0)
{
    _idle = spr_buster_idle;
    var _taunt = spr_bridget_taunt;
    _spr = buster_spr;
    _ind = buster_ind;
    _pal = pal_buster;
    _char = 0;
}
else
{
    _idle = spr_bridget_idle;
    var _taunt = spr_bridget_taunt;
    _spr = bridget_spr;
    _ind = bridget_ind;
    _pal = pal_bridget;
    _char = 1;
}

pal_swap(_pal, 0, global.palette[_char] + 1);
draw_sprite_ext(_spr, _ind, _x, _y + _player_yoff, _scale, _scale, 0, c_white, 1);
shader_reset();
shader_set(sha_flash);
draw_sprite_ext(_spr, _ind, _x, _y + _player_yoff + ((sprite_get_height(_spr) * (effect_scale - 1)) / 2), effect_scale * _scale, effect_scale * _scale, 0, c_white, effect_alpha);
shader_reset();

if (_glyph)
{
    _scale = 1.15;
    draw_glyph(global.input_menu_special_glyph, _x - 44, _y + 20, _scale, 1);
}

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
_x = 1445;
_y = (300 + menu_yoff + 300) - 45;
var _sep = menu_sep;
_scale = 2.5;
draw_set_font(obj_persistent.font_pixel);
var _player_scale = 0.91;

for (var i = 0; i < array_length(pals_bu); i++)
{
    var _pals;
    
    if (_char == 0)
        _pals = pals_bu;
    else
        _pals = pals_br;
    
    var _got = check_unlocked(_pals, i)[0];
    _str = check_unlocked(_pals, i)[1];
    _str = string_upper(_str);
    var __scale = 1;
    var _txt_xscale = 1;
    var _w = string_width(_str);
    var _w_max = 190;
    
    if (_w > _w_max)
        _txt_xscale = _w_max / _w;
    else
        _txt_xscale = 1;
    
    var _player_xoff = 0;
    
    if (selected == i)
    {
        __scale = 1.15;
        _player_xoff = -40;
    }
    
    pal_swap(_pal, 0, i + 1);
    draw_sprite_ext(_idle, 8, (_x - 320) + _player_xoff, _y + 48, _player_scale, _player_scale, 0, c_white, 1);
    shader_reset();
    
    if (!_got)
        draw_sprite_ext(_idle, 8, (_x - 320) + _player_xoff, _y + 48, _player_scale, _player_scale, 0, c_black, 1);
    
    draw_sprite_ext(spr_paused_bar, 0, _x, _y, __scale, __scale * 1.1, 0, c_white, 1);
    draw_text_transformed(_x, _y + 7, _str, _scale * __scale * _txt_xscale, _scale * __scale, 0);
    
    if (selected != i)
        draw_sprite_ext(spr_paused_bar, 0, _x, _y, __scale, __scale * 1.1, 0, c_black, 0.35);
    
    _y += _sep;
}

draw_set_valign(fa_top);
draw_set_halign(fa_left);
var _col = 0;
var _h = 80;
draw_rectangle_color(0, 0, 1920, _h, _col, _col, _col, _col, false);
draw_rectangle_color(0, 1080 - _h, 1920, 1080, _col, _col, _col, _col, false);
var _strs = ["SELECT", "BACK"];
var _glyphs = ["Z", "B"];

if (input_source_using(__input_global().__source_keyboard, 0))
    _glyphs[1] = "X";

for (var i = 0; i < 2; i++)
{
    _scale = 0.9;
    _x = 650;
    _y = 1010;
    
    if (i == 1)
        _x += 450;
    
    draw_glyph(_glyphs[i], _x, _y, _scale, _scale);
    draw_set_font(obj_persistent.font_pixel);
    draw_text_transformed(_x + 68, _y + 16, _strs[i], _scale * 2.5, _scale * 2.5, 0);
}

draw_set_halign(fa_center);
_x = 960;
_y = 9;
_scale = 3;
var _str = "PALETTES";
draw_text_transformed(_x, _y + 16, _str, _scale, _scale, 0);
draw_set_halign(fa_left);
surface_reset_target();
gpu_set_blendenable(false);
draw_surface(surf, 0, 0);
gpu_set_blendenable(true);
