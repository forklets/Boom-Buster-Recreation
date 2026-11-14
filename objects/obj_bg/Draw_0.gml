with (par_bg)
{
    if (bg_script != noone)
        bg_script();
}

if (!obj_editor.edit_mode)
    exit;

edit_move++;
editor_alpha = approach(editor_alpha, obj_editor.edit_mode, 0.125);

if (editor_alpha)
    draw_sprite_tiled_ext(spr_pattern, 0, edit_move * 0.5, edit_move * 0.25, 1.5, 1.5, c_white, editor_alpha * 0.8);

if (obj_editor.edit_mode)
{
    with (obj_editor)
    {
        draw_set_alpha(grid_alpha);
        
        for (var i = 0; i < (((room_width - 128) + 32) div grid_x); i++)
            draw_line(64 + (i * grid_x), 64, 64 + (i * grid_x), room_height - 64);
        
        for (var i = 0; i < ((room_height - 64) div grid_y); i++)
            draw_line(64, 64 + (i * grid_y), room_width - 64, 64 + (i * grid_y));
        
        draw_set_alpha(1);
    }
}
