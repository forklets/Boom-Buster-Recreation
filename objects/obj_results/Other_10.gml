var _scale = 1;
scroll_x++;
scroll_y++;
var _x = scroll_x;
var _y = scroll_y;
draw_sprite_tiled_ext(spr_results_bg, 0, _x, _y, _scale, _scale, c_white, 1);
var _col = 0;
var _h = 80;
draw_rectangle_color(0, 0, 1920, _h, _col, _col, _col, _col, false);
draw_rectangle_color(0, 1080 - _h, 1920, 1080, _col, _col, _col, _col, false);
var _strs, _glyphs;

if (room != rm_results)
{
    _strs = ["BACK"];
    _glyphs = ["B"];
    
    if (input_source_using(__input_global().__source_keyboard, 0))
        _glyphs[0] = "X";
}
else
{
    _strs = ["GO"];
    _glyphs = ["Z"];
}

for (var i = 0; i < array_length(_strs); i++)
{
    _scale = 0.9;
    _x = 670;
    _y = 1010;
    _x += 175;
    draw_glyph(_glyphs[i], _x, _y, _scale, 1);
    draw_set_font(obj_persistent.font_pixel);
    draw_text_transformed(_x + 68, _y + 16, _strs[i], _scale * 2.5, _scale * 2.5, 0);
}

draw_set_font(obj_persistent.font_pixel_gradient);
_scale = 3.25;
var _str;

if (global.bside)
    _str = "TOP 10 (B-SIDE)";
else
    _str = "TOP 10";

pal_swap(pal_font_gradient, 0, 4);
draw_set_halign(fa_center);
_x = (960 - ((string_width(_str) * _scale) / 2)) + ((string_width("T") * _scale) / 2);

for (var i = 0; i < string_length(_str); i++)
{
    var _chr = string_char_at(_str, i + 1);
    var _sin = sin((current_time / 125) + (pi * (i * 0.333)));
    var _cos = cos((current_time / 125) + (pi * (i * 0.333)));
    draw_text_transformed(_x + (_sin * 3), 23 + (_cos * 3), _chr, _scale + 0.2 + (_sin * 0.2), _scale + 0.2 + (_sin * 0.2), 0);
    _x += (string_width(_chr) * _scale);
}

draw_set_halign(fa_left);
shader_reset();
_x = 585;
_y = 133;
var _sep = 74;
var _xscale = 1;
var _yscale = 1;
_scale = 3.5;
var _max = 11;

if (new_highscore)
    _max = 10;

for (var i = 0; i < _max; i++)
{
    var _new = false;
    
    if (highscores[i] == my_score && i != 10)
        _new = true;
    
    if (i == 10)
        _y += 50;
    
    var _new_flash = !((round(current_time / 225) % 3) == 0);
    
    if (flash_delay > 0)
        _new_flash = true;
    
    if (_new && _new_flash)
    {
        pal_swap(pal_font_gradient, 0, 1);
        var __xoff;
        
        if (i == (_max - 1))
            __xoff = -30;
        else
            __xoff = 0;
        
        draw_text_transformed((_x - 270) + __xoff, _y + (_sep * i), "NEW!", 3, 3, 0);
        shader_reset();
    }
    
    if (i == 10 && room != rm_results)
        continue;
    
    if (i == 10)
        _str = "YOU";
    else
        _str = $"{i + 1}";
    
    draw_set_halign(fa_right);
    draw_text_transformed(_x, _y + (_sep * i), _str, _scale * _xscale, _scale * _yscale, 0);
    draw_set_halign(fa_left);
    
    if (i != 10)
    {
        pal_swap(pal_font_gradient, 0, 1);
        
        if (!_new)
        {
            draw_text_transformed(_x + 100, _y + (_sep * i), $"{highscores[i][0]}", _scale * _xscale, _scale * _yscale, 0);
        }
        else
        {
            var _name = highscores[i][0];
            _xx = _x + 100;
            
            for (var ii = 0; ii < string_length(_name); ii++)
            {
                var _chr = string_char_at(_name, ii + 1);
                
                if (initial_index == ii)
                {
                    if (_new && _new_flash)
                        draw_text_transformed(_xx, _y + (_sep * i), $"{_chr}", _scale * _xscale, _scale * _yscale, 0);
                }
                else
                {
                    draw_text_transformed(_xx, _y + (_sep * i), $"{_chr}", _scale * _xscale, _scale * _yscale, 0);
                }
                
                if (initial_index == ii)
                {
                    var __scale = 1.5;
                    draw_sprite_ext(spr_results_arrow, 0, _xx + 12, (_y + (_sep * i)) - 19, __scale, __scale, 0, c_white, 1);
                    draw_sprite_ext(spr_results_arrow, 1, _xx + 12, _y + (_sep * i) + 50, __scale, __scale, 0, c_white, 1);
                }
                
                _xx += (string_width(_chr) * _scale);
            }
        }
    }
    
    shader_reset();
    pal_swap(pal_font_gradient, 0, 2);
    _str = "$" + string_add_zeros(highscores[i][1], 5, 2);
    var _dark = true;
    var _xx = _x;
    
    for (var ii = 0; ii < string_length(_str); ii++)
    {
        var _chr = string_char_at(_str, ii + 1);
        
        if (_chr != "$" && _chr != "0" && _chr != ".")
        {
            if (_chr != "$" && _chr != "0" && _chr != ".")
                _dark = false;
        }
        
        draw_text_transformed(_xx + 340, _y + (_sep * i), _chr, _scale * _xscale, _scale * _yscale, 0);
        
        if (_dark && _chr != "$")
        {
            draw_set_color(c_black);
            draw_set_alpha(0.4);
            draw_text_transformed(_xx + 340, _y + (_sep * i), _chr, _scale * _xscale, _scale * _yscale, 0);
            draw_set_alpha(1);
            draw_set_color(c_white);
        }
        
        _xx += (string_width(_chr) * _scale);
    }
    
    shader_reset();
}
