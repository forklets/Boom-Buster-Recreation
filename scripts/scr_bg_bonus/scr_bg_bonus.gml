function scr_bg_bonus()
{
    get_cams();
    var _dist = 0.4;
    var _x = (camx * _dist) + 16;
    var _y = camy * _dist;
    draw_bg(spr_bg_bonus, 1, _x, _y);
    draw_bg(spr_bg_bonus, 0, _x, _y);
    _dist = 0.3;
    _x = (camx * _dist) - 0;
    _y = camy * _dist;
    draw_bg(spr_bg_bonus_stars, 0, _x, _y);
    _dist = 0.2;
    _x = (camx * _dist) - 5;
    _y = camy * _dist;
    draw_bg(spr_bg_bonus_clouds_0, 0, _x, _y);
    draw_bg(spr_bg_bonus_clouds_1, 0, _x, _y);
    draw_set_alpha(0.2);
    draw_set_color(#592884);
    draw_rectangle(camx, camy, camx + 1920, camy + 1080, false);
    draw_set_color(c_white);
    draw_set_alpha(1);
    
    if (!surface_exists(surf_shadows))
        surf_shadows = surface_create(room_width, room_height);
    
    surface_set_target(surf_shadows);
    draw_clear_alpha(c_white, 0);
    _dist = 9;
    var _objects = [par_player, obj_coin, obj_crate, obj_buzzsaw, obj_onoff_block, obj_wings_away, obj_spike, obj_block_stone, obj_cannon];
    
    for (var i = 0; i < array_length(_objects); i++)
    {
        with (_objects[i])
        {
            _x = x;
            _y = y;
            x += _dist;
            y += _dist;
            event_perform(ev_draw, ev_draw_normal);
            x = _x;
            y = _y;
        }
    }
    
    with (obj_controller)
        draw_sprite(blood_mask, 0, 0 + _dist, 0 + _dist);
    
    surface_reset_target();
    draw_surface_ext(surf_shadows, 0, 0, 1, 1, 0, c_black, 0.5);
}
