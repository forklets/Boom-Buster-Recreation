function scr_bg_city()
{
    var _clouds_yoff, _yoff;
    
    if (room == rm_mall_extra1)
    {
        _yoff = 600;
        _clouds_yoff = 200;
        
        with (obj_fog)
        {
            image_yscale = 3;
            image_alpha = 0.75;
        }
    }
    else
    {
        _yoff = 0;
        _clouds_yoff = 0;
    }
    
    get_cams();
    clouds_x -= 0.12;
    
    if (clouds_x <= -sprite_get_width(spr_bg_boomtown_clouds))
        clouds_x -= clouds_x;
    
    var _move;
    
    if (keyboard_check(vk_shift) && global.debug)
        _move = [6, 12];
    else
        _move = [0.12, 0.24];
    
    for (var i = 0; i < 2; i++)
    {
        fog_x[i] -= _move[i];
        
        if (fog_x[i] <= (-sprite_get_width(spr_fog_single) * 4))
            fog_x[i] -= fog_x[i];
    }
    
    var _fade = 13026742;
    _fade = 11706761;
    draw_bg(spr_bg_boomtown_sky, 1, camx, camy);
    draw_bg_ext(spr_bg_boomtown_sky, 2, camx, camy, 1, 1, 0, 16777215, 0.2, 0);
    draw_bg_ext(spr_bg_boomtown_clouds, 0, camx + clouds_x, camy + 12 + _clouds_yoff, 1, 1, 0, 16777215, 0.5, undefined, undefined, true);
    draw_bg(spr_bg_boomtown_farback, 0, camx, camy + _yoff);
    draw_bg_ext(spr_bg_boomtown_farback, 1, camx, camy + _yoff, 1, 1, 0, _fade, 0.4470588235294118);
    var _dist = 0.9;
    draw_bg(spr_bg_boomtown_back, 0, camx * _dist, (camy * _dist) + _yoff, 0.5882352941176471, _fade);
    var _billboards = 
    {
        rm_round_2: spr_bg_boomtown_billboard,
        rm_round_4: spr_bg_boomtown_billboard,
        rm_round_5: spr_bg_boomtown_billboard,
        rm_round_6: spr_bg_boomtown_billboard_wiz,
        rm_round_8: spr_bg_boomtown_billboard
    };
    var _room = room_get_name(room);
    
    if (struct_exists(_billboards, _room))
    {
        _dist = 0.825;
        draw_bg(struct_get(_billboards, _room), 0, camx * _dist, (camy * _dist) + _yoff, 0.47058823529411764, _fade);
    }
    
    _dist = 0.75;
    draw_bg(spr_bg_boomtown_mid, 0, camx * _dist, (camy * _dist) + _yoff, 0.3215686274509804, _fade);
    scr_bg_draw_tower(_fade);
    _dist = 1;
    var _x = (camx * _dist) - 0;
    var _y = camy;
    gpu_set_texfilter(true);
    var _w = sprite_get_width(spr_fog_single) * 4;
    
    for (var i = 0; i < 2; i++)
    {
        _dist = 0.7;
        _x = (camx * _dist) - 450 - fog_x[0] - (_w * i);
        _y = ((camy * _dist) - 200) + 110;
        draw_sprite_ext(spr_fog_single, 0, _x, _y, 4, 4, 0, c_white, 0.20592000000000002);
    }
    
    for (var i = 0; i < 2; i++)
    {
        _dist = 0.4;
        _x = (camx * _dist) - 450 - fog_x[1] - (_w * i);
        _y = ((camy * _dist) - 200) + 160;
        draw_sprite_ext(spr_fog_single, 0, _x, _y, 4, 4, 0, c_white, 0.2772);
    }
    
    gpu_set_texfilter(global.texfilter);
}
