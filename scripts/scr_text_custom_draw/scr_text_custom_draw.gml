function scr_text_custom_draw(arg0, arg1, arg2, arg3, arg4)
{
    var _y = arg1;
    var _sep = arg4;
    var _scale = arg3;
    
    for (var l = 0; l < array_length(arg2); l++)
    {
        var _glyph_count = 0;
        var _x = arg0 - ((arg2[l].width * _scale) / 2);
        
        for (var c = 0; c < array_length(arg2[l].characters); c++)
        {
            var _xoff = 0;
            var _yoff = 0;
            var _xchance = choose(0, 0, 0, 1);
            var _ychance = choose(0, 0, 0, 1);
            _xoff += (irandom_range(-1, 1) * _xchance);
            _yoff += (irandom_range(-1, 1) * _ychance);
            var _chr = arg2[l].characters[c];
            
            if (_chr == "<")
            {
                var _glyph = arg2[l].glyphs[_glyph_count];
                _glyph_count++;
                
                if (_glyph == "0")
                    draw_sprite_ext(spr_orb, 0, _x + 17, _y + 16, 1, 1, 0, c_white, draw_get_alpha());
                else
                    draw_glyph(_glyph, _x - 17, _y - 20, 1, draw_get_alpha());
                
                c++;
                _x += sprite_get_width(spr_glyph_keyboard);
            }
            else if (_chr == "/")
            {
                _y += _sep;
            }
            else
            {
                draw_text_transformed(_x + _xoff, _y + _yoff, _chr, _scale, _scale, 0);
                _x += (string_width(_chr) * _scale);
            }
        }
    }
}
