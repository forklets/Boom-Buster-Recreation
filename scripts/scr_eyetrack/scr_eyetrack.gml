function scr_eyetrack()
{
    if (eyes_sprite != noone && array_contains(possible_eyes, anim_sprite))
    {
        get_eyes();
        
        if (collision_rectangle(eX1, eY1, eX2, eY2, obj_player, false, false) && obj_player.mask_index != -1)
        {
            var _h;
            
            if (sprite_exists(mask_index))
                _h = sprite_get_height(mask_index) / 2;
            else
                _h = sprite_get_height(sprite_index) / 2;
            
            var _ph = sprite_get_height(obj_player.mask_index);
            var _angle = point_direction(x, y - (_h / 2), obj_player.x, obj_player.y - (_ph / 2));
            var _eyes_xTo = dsin(_angle + 90) * eyes_lenX;
            var _eyes_yTo = dcos(_angle + 90) * eyes_lenY;
            
            if (eyes_lenX_min != -999 && eyes_lenX_max != -999)
                _eyes_xTo = clamp(_eyes_xTo, eyes_lenX_min, eyes_lenX_max);
            
            if (eyes_lenY_min != -999 && eyes_lenY_max != -999)
                _eyes_yTo = clamp(_eyes_yTo, eyes_lenY_min, eyes_lenY_max);
            
            eyes_xoff += ((_eyes_xTo - eyes_xoff) / eyes_lag);
            eyes_yoff += ((_eyes_yTo - eyes_yoff) / eyes_lag);
        }
        else
        {
            eyes_xoff += ((0 - eyes_xoff) / eyes_lag);
            eyes_yoff += ((0 - eyes_yoff) / eyes_lag);
        }
        
        draw_sprite_ext(eyes_sprite, anim_index, x + eyes_xoff + (eyes_spr_xoff * facing), y + eyes_yoff, facing, 1, 0, image_blend, image_alpha);
        
        if (eyelids_sprite != noone)
            draw_sprite_ext(eyelids_sprite, anim_index, x, y, facing, 1, 0, image_blend, image_alpha);
    }
}
