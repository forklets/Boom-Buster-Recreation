if (!draw_cutscene)
    exit;

draw_set_font(obj_persistent.font_pixel);

for (var j = 0; j < array_length(texts); j++)
{
    _str = texts[j];
    var _x = text_xstart;
    var _y = text_ystart + text_y + (text_sep * j) + y;
    var _y_sep = 70;
    
    for (var i = 0; i < string_length(_str); i++)
    {
        if (slide != j && slide != (j + 1) && slide != (j - 1))
            continue;
        
        var _chr = string_char_at(_str, i + 1);
        var _chr_next = string_char_at(_str, i + 2);
        
        if (_chr == "<")
        {
            if (_chr_next == "o")
                draw_set_color(#FF5200);
            else if (_chr_next == "w")
                draw_set_color(c_white);
            else if (_chr_next == "c")
                draw_set_color(#1DD4C8);
            else if (_chr_next == "l")
                draw_set_color(#D7FF3C);
            else if (_chr_next == "r")
                draw_set_color(c_red);
            
            i++;
        }
        else if (_chr == "/")
        {
            _x = text_xstart;
            _y += _y_sep;
        }
        else
        {
            _chr = string_upper(_chr);
            var __x = _x;
            var __y = _y;
            draw_text_transformed(__x, __y, _chr, scale * xscale, scale * yscale, 0);
            
            if (_chr == " ")
                _x += (blank_width * scale * xscale);
            else
                _x += (string_width(_chr) * scale * xscale);
        }
    }
    
    draw_set_color(c_white);
}

draw_sprite_ext(spr_cutscene_border, 1, 0, y, 1, 1, 0, c_red, 1);

if (!deac && !go)
    draw_sprite(spr_cutscene_go, 0, 1711, 1016 + (arrow_move * 5) + y);

if (cutscene_index != -4)
    draw_sprite(cutscene_sprite, cutscene_index, 226, 58 + y);

draw_set_font(obj_persistent.font_pixel_outline);
draw_set_alpha(skip_alpha);
draw_set_halign(fa_center);
var _str = "PRESS 'PAUSE' TO SKIP";

if (global.theater != noone)
    _str = "PRESS 'PAUSE' TO EXIT";

draw_text_transformed(960, 20, _str, 1.5, 1.5, 0);
draw_set_halign(fa_left);
draw_set_alpha(1);
