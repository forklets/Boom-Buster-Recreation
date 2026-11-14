if (obj_editor.edit_mode && mypath != noone && ready)
{
    if (keyboard_check_pressed(ord("Q")) && obj_editor.element_selected != noone)
    {
        var _element = global.elements[obj_editor.element_selected];
        editor_pos = ((mypath_spd * _element.timestamp) + path_pos_start) % 1;
    }
    
    if (keyboard_check(vk_control))
        editor_pos = ((mypath_spd * (window_mouse_get_y() - obj_editor.scroll_y)) + path_pos_start) % 1;
    
    var _x = path_get_x(mypath, editor_pos);
    var _y = path_get_y(mypath, editor_pos);
    
    if (!sprite_exists(mask_index))
        var _spr = sprite_index;
    else
        var _spr = mask_index;
    
    draw_sprite_ext(anim_sprite, anim_index, _x, _y, facing * xscale, yscale, 0, c_white, 1);
    draw_sprite_ext(face_sprite, face_ind, _x, _y, facing * xscale, yscale, 0, c_white, 1);
    draw_set_font(fnt_debug);
    
    if (land_id != noone)
        draw_text(_x, _y - 25, land_id);
}
else
{
    draw_sprite_ext(anim_sprite, anim_index, x, y, facing * xscale, yscale, 0, c_white, 1);
    draw_sprite_ext(face_sprite, face_ind, x, y, facing * xscale, yscale, 0, c_white, 1);
}
