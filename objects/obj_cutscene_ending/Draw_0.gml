event_inherited();
draw_set_font(obj_persistent.font_pixel);
draw_sprite_ext(cutscene_sprite, 5, 226, 58 + y, 1, 1, 0, c_white, bw_alpha);
var _y = y + 1080 + 180;
var _scale = 0.25;
draw_sprite_ext(spr_logo, 0, 960, _y, _scale, _scale, 0, c_white, 1);
var _x = 100;
_y += 260;
_scale = 2;
var _sep = 56;
var _sep_row = 80;
draw_set_alpha(credits_alpha);

for (var i = 0; i < array_length(credits); i++)
{
    for (var j = 0; j < array_length(credits[i]); j++)
    {
        if (j == 0 && i < (array_length(credits) - 11))
            draw_set_color(c_yellow);
        else
            draw_set_color(c_white);
        
        var _yy;
        
        if (i == (array_length(credits) - 1))
        {
            _yy = _y;
            var _max = 1010;
            
            if (_yy <= _max)
                _yy = _max;
        }
        else
        {
            _yy = _y;
        }
        
        draw_text_transformed(_x, _yy, string_upper(credits[i][j]), _scale * 0.95, _scale, 0);
        draw_set_color(c_white);
        _y += _sep;
    }
    
    _y += _sep_row;
    
    if (i == (array_length(credits) - 1) && final_y == undefined)
        final_y = _y;
}

draw_set_alpha(1);
