draw_set_halign(fa_center);
draw_set_font(obj_persistent.font_pixel_outline);
var _x = 960;
var _y = 15;
var _scale = 3.5;
var _str = string_add_zeros(time, 1, 2);

if (time <= 0)
    _str = "0.00";

draw_text_transformed(_x, _y, _str, _scale, _scale, 0);
draw_set_halign(fa_left);

if (!screen_results)
    exit;

draw_set_alpha(overlay_alpha);
draw_rectangle_color(0, 0, 1920, 1080, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);
var _col = 0;
var _h = 80;
draw_rectangle_color(0, 0, 1920, _h, _col, _col, _col, _col, false);
draw_rectangle_color(0, 1080 - _h, 1920, 1080, _col, _col, _col, _col, false);
draw_set_halign(fa_center);
draw_set_font(obj_persistent.font_pixel_outline);
_x = 960;
_y = 15;
_scale = 3.5;
_str = string_add_zeros(time, 1, 2);

if (time <= 0)
    _str = "0.00";

draw_text_transformed(_x, _y, _str, _scale, _scale, 0);
draw_set_halign(fa_left);
draw_set_alpha(go_alpha);
var _strs = ["GO"];
var _glyphs = ["Z", "B"];

if (input_source_using(__input_global().__source_keyboard, 0))
    _glyphs[1] = "X";

for (var i = 0; i < array_length(_strs); i++)
{
    _scale = 0.9;
    _x = 890;
    _y = 1010;
    
    if (i == 1)
        _x += 450;
    
    draw_glyph(_glyphs[i], _x, _y, _scale, go_alpha);
    draw_set_font(obj_persistent.font_pixel);
    draw_text_transformed(_x + 68, _y + 16, _strs[i], _scale * 2.5, _scale * 2.5, 0);
}

draw_set_alpha(1);
draw_set_font(obj_persistent.font_pixel_outline);
_x = 340;
_y = 450;

if (global.players == 1)
    _y = 500;

var _names = ["BUSTER", "BRIDGET"];
var _sprs;

if (global.bside)
    _sprs = [spr_buster_idle_goggles, spr_bridget_idle_goggles];
else
    _sprs = [spr_buster_idle, spr_bridget_idle];

if (epic_fail)
    _sprs = [spr_buster_pain2, spr_bridget_pain2];

var _inds = [7, 5];
var _pals = [pal_buster, pal_bridget];
var _player_yoff, _yoff;

if (global.players == 2)
{
    _player_yoff = 0;
    _yoff = -42;
}
else
{
    _player_yoff = 40;
    _yoff = 0;
}

for (var p = 0; p < global.players; p++)
{
    _x = 340;
    var _chr = global.player_character[p];
    var _name = _names[_chr];
    _scale = 1.5;
    pal_swap(_pals[_chr], 0, 1);
    
    if (p == 1)
        _y = 660;
    
    draw_sprite_ext(_sprs[_chr], _inds[_chr], _x, _y + 48 + _player_yoff + _yoff, _scale, _scale, 0, c_white, 1);
    shader_reset();
    _x += 125;
    _y -= 90;
    _scale = 2.5;
    draw_text_transformed(_x, _y + ((p == 0) ? 50 : -50) + 40 + _yoff, $"{_name}", _scale, _scale, 0);
    var _shorten = (coins_tallied >= 2000) ? 0 : 1;
    
    if (global.players < 2)
        _shorten = 1;
    
    _y += 115;
    _y -= coin_dist_smooth;
    _x += 360;
    var _xstart = _x;
    var _count = 0;
    
    if (p >= 1)
        break;
    
    for (var i = 0; i < global.coins_collected; i++)
    {
        _scale = 1.5;
        
        if ((coins_tallied - 1) >= i)
        {
            var _jump = 0;
            var _frame = 4;
            
            if (i == (coins_tallied - 1))
            {
                _jump = coin_y;
                _frame = coin_vspd % 16;
            }
            
            if ((_y + _jump) > _y)
                _frame = 4;
            
            draw_sprite_ext(spr_coin, _frame, _x, min(_y, _y + _jump), _scale, _scale, 0, c_white, 1);
        }
        
        _x += 100;
        _count++;
        
        if (_count >= 8)
        {
            _x = _xstart;
            _y += 100;
            _count = 0;
        }
        
        if (!_shorten)
            break;
    }
    
    _y += 100;
}

if (bonus)
{
    draw_set_colour(c_lime);
    scr_text_custom_draw(860, text_y, text_perfect, 3 * max(scale_ease, 0), 50);
    draw_set_color(c_white);
}

if (epic_fail)
{
    draw_set_halign(fa_center);
    _x = 960;
    _y = 140;
    _scale = 4;
    draw_text_transformed(_x, _y, "0 CRATES. EPIC FAIL", _scale, _scale, 0);
    draw_set_halign(fa_left);
}
