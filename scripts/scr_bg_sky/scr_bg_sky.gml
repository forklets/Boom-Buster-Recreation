function scr_bg_sky()
{
    get_cams();
    var _fade = 16249019;
    _fade = 15591616;
    draw_bg(spr_bg_mall_sky, 0, camx, camy);
    draw_bg_ext(spr_bg_boomtown_clouds, 0, camx + clouds_x, camy + 12, 1, 1, 0, 16777215, 0.7);
    
    if (!exit_freeze())
        clouds_x -= 0.12;
    
    if (clouds_x <= -sprite_get_width(spr_bg_boomtown_clouds))
        clouds_x -= clouds_x;
}
