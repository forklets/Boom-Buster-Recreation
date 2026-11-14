if (menu_selected != menu_main)
{
    draw_set_font(obj_persistent.font_pixel_outline);
    var _old = draw_get_halign();
    draw_set_halign(fa_center);
    var _x = 960;
    var _y = 300;
    
    if (instance_exists(obj_paused))
    {
        _x = global.app_xoff + 704;
        _y = 300;
    }
    
    var y_dist = 100;
    var txt_draw = "";
    hand_x = _x - (string_width(menu_selected.options[selected_option]) / 2) - 100;
    var remap_menu = variable_struct_exists(menu_selected, "player");
    
    if (remap_menu)
    {
        _y -= 255;
        y_dist = 83;
    }
    
    for (var i = 0; i < array_length(menu_selected.options); i++)
    {
        txt_draw = menu_selected.options[i];
        
        if (remap_menu)
        {
            if (menu_selected.options[i] == "PLAYER")
            {
                txt_draw = string("[ PLAYER {0}]", menu_selected[$ "player"] + 1);
                
                if (selected_option == i)
                    txt_draw = string("- PLAYER {0} -", menu_selected[$ "player"] + 1);
            }
            
            if (i >= 1 && i <= (array_length(menu_selected.options) - 3))
            {
                var _t = menu_selected.options[i];
                
                if (_t == "JUMP")
                    _t = "JUMP/ACCEPT";
                
                if (_t == "SPIN")
                    _t = "SPIN/CANCEL";
                
                txt_draw = string("{0}:  {1}", _t, key_names[variable_global_get("key_" + string_lower(menu_selected.options[i]))[menu_selected.player]]);
                
                if (button_time > 0 && selected_option == i)
                    txt_draw = $"{_t}: ...";
            }
        }
        
        switch (txt_draw)
        {
            case "PAD DEADZONE":
                var _str = (global.deadzone == 0) ? "LOW" : ((global.deadzone == 1) ? "NORMAL" : "HIGH");
                txt_draw = $"PAD DEADZONE:  {_str}";
                break;
            
            case "RESOLUTION":
                var _str = $"{obj_persistent.resW[global.resolution]}x{obj_persistent.resH[global.resolution]}";
                txt_draw = $"RESOLUTION:  {_str}";
                break;
            
            case "FULLSCREEN":
                txt_draw = string("FULLSCREEN:  {0}", window_get_fullscreen() ? "ON" : "OFF");
                break;
            
            case "COLORBLIND":
                txt_draw = string("COLORBLIND:  {0}", global.colorblind ? "ON" : "OFF");
                break;
            
            case "VSYNC":
                txt_draw = string("VSYNC:  {0}", global.vsync ? "ON" : "OFF");
                break;
            
            case "MASTER":
                txt_draw = $"MASTER VOL:  {global.master_vol * 100}%";
                break;
            
            case "BGM":
                txt_draw = $"BGM VOL:  {global.bgm_vol * 100}%";
                break;
            
            case "SFX":
                txt_draw = $"SFX VOL:  {global.sfx_vol * 100}%";
                break;
            
            case "VOICE":
                txt_draw = string("VOICE CLIPS:  {0}", global.voice_clips ? "ON" : "OFF");
                break;
        }
        
        draw_set_color(c_black);
        
        if (selected_option == i)
        {
            draw_set_color(#FFD400);
            hand_x = _x - (string_width(txt_draw) / 2) - 100;
        }
        else
        {
            draw_set_color(c_white);
        }
        
        draw_text_shake(_x, _y + (y_dist * i), string_upper(txt_draw), 0, 3, 3);
        draw_set_color(c_white);
    }
    
    draw_set_halign(_old);
    
    if (invalid_time != -1)
    {
        var _a = draw_get_alpha();
        
        if (invalid_time <= 60)
            draw_set_alpha(invalid_time / 60);
        
        draw_set_colour(c_ltgray);
        draw_set_colour(c_red);
        draw_text_shake_transformed(32, 1025, invalid_str, 0.3, 1.5, 1.5);
        draw_set_alpha(_a);
        draw_set_colour(c_white);
    }
}
else
{
    event_inherited();
}
