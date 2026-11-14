draw_sprite(bgr_title, global.colorblind, (global.screenshake[0] - 10) + bg_x + 10, global.screenshake[1] - 10);
var _col = 0;
draw_set_alpha(0.35);
draw_rectangle_color(0, 0, 1920, 1080, _col, _col, _col, _col, false);
draw_set_alpha(1);

if (instance_exists(obj_roundselect))
{
    var _boxW = sprite_get_width(spr_title_box);
    _x = (1920 - _boxW) + box_x;
    var _roundselect_column = -4;
    
    if (instance_exists(obj_roundselect))
        _roundselect_column = obj_roundselect.menu;
    
    var _static_alpha;
    
    if (_roundselect_column != -1)
        _static_alpha = 0.55;
    else
        _static_alpha = 1;
    
    if (_roundselect_column == 0 && array_contains(global.save.stages_beat, "rm_round_1"))
    {
        draw_sprite(spr_bg_boomtown_sky, 0, _x, 0);
        draw_sprite(spr_bg_boomtown_clouds, 0, _x, 0);
        draw_sprite(spr_bg_boomtown_farback, 0, _x, 0);
        draw_sprite(spr_bg_boomtown_back, 0, _x, 0);
        draw_sprite(spr_bg_boomtown_mid, 0, _x, 200);
    }
    else if (_roundselect_column == 1 && array_contains(global.save.stages_beat, "rm_round_8"))
    {
        draw_sprite(spr_bg_mall, 0, _x, -90);
    }
    else if (_roundselect_column == 2 && array_contains(global.save.stages_beat, "rm_round_15"))
    {
        draw_sprite(spr_bg_factory_farback, 0, _x, 0);
        draw_sprite_ext(spr_bg_factory_gear, 0, _x + 230, 900, 1, 1, current_time / 100, c_white, 1);
        draw_sprite_ext(spr_bg_factory_gear, 0, _x + 880, 200, 1, 1, -current_time / 100, c_white, 1);
        draw_sprite(spr_bg_factory_pipes, 0, _x, 0);
    }
    else if (_roundselect_column == 3 && array_contains(global.save.stages_beat, "rm_outskirts_1"))
    {
        draw_sprite(spr_bg_outskirts_sky, 0, _x, 0);
        draw_sprite(spr_bg_outskirts_clouds_top0, 0, _x, -100);
        draw_sprite(spr_bg_outskirts_clouds_top2, 0, _x, 0);
        draw_sprite(spr_bg_outskirts_mountains, 0, _x, 230);
        draw_sprite(spr_bg_outskirts_mountains_closer, 0, _x, 330);
        draw_sprite(spr_bg_outskirts_tower0, 0, _x + 320, 1100);
        draw_sprite(spr_bg_outskirts_tower0, 0, _x + 700, 1000);
        draw_sprite(spr_bg_outskirts_clouds_bottom0, 0, _x, 800);
        draw_sprite(spr_bg_outskirts_clouds_bottom2, 0, _x, 800);
    }
    else if (_roundselect_column == 4 && array_contains(global.save.stages_beat, "rm_bonus_1"))
    {
        draw_sprite(spr_bg_bonus, 1, _x, 0);
        draw_sprite(spr_bg_bonus, 0, _x, 0);
        draw_sprite(spr_bg_bonus_stars, 0, _x, 0);
    }
    else
    {
        _static_alpha = 1;
    }
    
    var _w = sprite_get_width(spr_static);
    var _h = sprite_get_height(spr_static);
    
    for (var i = 0; i < 2; i++)
    {
        for (var j = 0; j < 3; j++)
        {
            _col = make_colour_hsv(255, 0, 89.25);
            draw_sprite_ext(spr_static, current_time / 60, _x + (_w * i), 0 + (j * _h), 1, 1, 0, _col, _static_alpha);
        }
    }
}

draw_set_font(obj_persistent.font_pixel);
var _scale = 4.5;
var _x = 960;
var _y = 790;

if (start_flash)
{
    draw_set_color(c_black);
    draw_set_alpha(0.4 + (sin(current_time / 150) * 0.05));
    draw_rectangle(0, _y - 18, _x + 1920, _y + 55 + 18, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
    var _str = "PRESS ANY BUTTON";
    var _w = string_width(_str) * _scale;
    var _xx = _x - (_w / 2);
    var _order = [1, 1, -2, 1, -2, 2, -1, 1];
    var _order_i = 0;
    
    for (var i = 0; i < string_length(_str); i++)
    {
        var _chr = string_char_at(_str, i + 1);
        var _xxx = _xx;
        var _yyy = _y;
        
        if (abs(_order[_order_i]) == 1)
            _xxx += (sin((current_time / 85) + (pi * i * 0.35)) * sign(_order[_order_i]));
        else
            _yyy += (sin((current_time / 85) + (pi * i * 0.35)) * sign(_order[_order_i]));
        
        _order_i++;
        
        if (_order_i > (array_length(_order) - 1))
            _order_i = 0;
        
        draw_text_transformed(_xxx + bg_x, _yyy, _chr, _scale, _scale, 0);
        _xx += (string_width(_chr) * _scale);
    }
}

_scale = 2;
draw_set_halign(fa_center);
draw_set_alpha(copyright_alpha);
draw_text_transformed(_x, 1030, "(C) TALLGLASS 2026", _scale, _scale, 0);
draw_set_alpha(1);
draw_set_halign(fa_left);
