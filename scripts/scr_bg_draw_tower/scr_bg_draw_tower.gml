function scr_bg_draw_tower(arg0)
{
    var _fade = arg0;
    
    if (instance_exists(obj_tower))
    {
        with (obj_tower)
        {
            get_cams();
            var _dist = 0.65;
            var _distY = 0.65;
            
            if (array_contains(global.stages_outskirts, room))
                _distY = 1;
            
            var _w = sprite_get_width(spr_tower);
            var _h = sprite_get_height(spr_tower);
            var _x = (camx * _dist) + ((room_width - 128) / 2);
            var _y = ((camy * _distY) + room_height) - 64 - _h - 100;
            
            if (room == rm_round_7_3 || room == rm_round_b7_3 || room == rm_round_7_1 || room == rm_round_b7_1)
            {
                _x -= 52;
            }
            else if (room == rm_round_21_3 || room == rm_round_b21_3)
            {
                _x -= 54;
                _y += 72;
            }
            else if (array_contains(global.stages_outskirts, room))
            {
                _x -= 124;
                _y -= 220;
            }
            
            var _xshake = shake * random_range(-14, 14);
            var _yshake = shake * random_range(-5, 5);
            var _fade_alpha = 0.47058823529411764;
            
            if (room == rm_round_21_3 || room == rm_round_b21_3)
                _fade_alpha = 0.5490196078431373;
            
            draw_bg(spr_tower, global.bside, _x + _xshake, _y + _yshake + y_sink, _fade_alpha, _fade, false);
            x = _x;
            y = _y;
        }
    }
    
    with (obj_bom_shoot)
    {
        if (vspd > 0)
        {
            var _scale = 0.55;
            visible = true;
            draw_bg_ext(anim_sprite, anim_index, x, y, _scale, _scale, 0, 16777215, 1, 0.47058823529411764, _fade, false);
            visible = false;
        }
    }
    
    with (obj_fx_explosion)
    {
        if (bg)
        {
            var _scale = 0.55;
            visible = true;
            draw_bg_ext(anim_sprite, anim_index, x, y, _scale, _scale, 0, 16777215, 1, 0.47058823529411764, _fade, false);
            visible = false;
        }
    }
}
