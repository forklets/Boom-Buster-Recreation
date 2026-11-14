function scr_bg_sunset()
{
    get_cams();
    var _fade = 5125855;
    var _dome;
    
    if (obj_controller.stage_event == "wizard")
        _dome = bgr_city_sunset_dome_wizard;
    else
        _dome = bgr_city_sunset_dome;
    
    draw_bg(bgr_city_sunset_sky, 0, camx, camy);
    draw_bg_ext(spr_bg_boomtown_clouds, 0, camx + clouds_x, camy + 12, 1, 1, 0, 16777215, 0.5, undefined, undefined, true);
    draw_bg_ext(spr_bg_boomtown_farback_sunset, 0, camx, camy, undefined, undefined, undefined, undefined, undefined, 0.27450980392156865, _fade);
    _fade = 6294176;
    draw_bg(spr_bg_boomtown_back, 0, camx * 0.94, camy + 50, 0.39215686274509803, _fade);
    _fade = 6303418;
    draw_bg_ext(bgr_city_sunset, 1, (camx * 0.89) - 64, camy, 1, 1, 0, 16777215, 1, 0.2, _fade);
    draw_sprite_ext(bgr_city_sunset_dome_empty, 0, (camx * 0.85) - 64, camy - 20, 1, 1, 0, c_white, 1);
    
    if (global.dome_ind != -1 && global.dome_ind < sprite_get_number(_dome))
        draw_sprite_ext(_dome, global.dome_order[global.dome_ind], (camx * 0.85) - 64, camy - 20, 1, 1, 0, c_white, global.dome_alpha);
    
    draw_bg_ext(bgr_city_sunset, 2, (camx * 0.72) - 55, camy, 1, 1, 0, 16777215, 1, 0.15, _fade);
    draw_bg_ext(bgr_city_sunset, 3, (camx * 0.64) - 32, camy, 1, 1, 0, 16777215, 1, 0.15, _fade);
    
    if (!exit_freeze())
    {
        clouds_x -= 0.12;
        timer_logic(0);
        global.dome_alpha = approach(global.dome_alpha, global.dome, 0.01);
    }
    
    if (clouds_x <= -sprite_get_width(spr_bg_boomtown_clouds))
        clouds_x -= clouds_x;
    
    scr_bg_draw_tower(_fade);
}
