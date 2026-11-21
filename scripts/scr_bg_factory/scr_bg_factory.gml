function scr_bg_factory()
{
    var _gear_ind = global.bside;
    get_cams();
    var _gear_angle = current_time / 70;
    var _fade;

    if (global.bside)
    {
        _fade = 6170938;

        if (!exit_freeze())
        {
            clouds_x -= 0.12;

            if (clouds_x <= -sprite_get_width(spr_bg_boomtown_clouds))
                clouds_x -= clouds_x;
        }

        draw_bg_ext(spr_bg_factory_b_sky, 0, camx, camy, 2, 1, 0, 16777215, 1, 0, 16777215, false);
        draw_bg_ext(spr_bg_boomtown_clouds, 0, camx + clouds_x, (camy + 12) - 10, 1, 1.4, 0, 16777215, 0.2, undefined, undefined, true);
        _scale = 0.5;
        _w = sprite_get_width(spr_bg_boomtown_farback_b) * _scale;
        _y = camy + 430;
        draw_bg_ext(spr_bg_boomtown_farback_b, 0, camx, _y, _scale, _scale, 0, 16777215, 1);
        draw_bg_ext(spr_bg_boomtown_farback_b, 1, camx, _y, _scale, _scale, 0, _fade, 1);
        draw_bg_ext(spr_bg_boomtown_farback_b, 0, camx + _w, _y, _scale, _scale, 0, 16777215, 1);
        draw_bg_ext(spr_bg_boomtown_farback_b, 1, camx + _w, _y, _scale, _scale, 0, _fade, 1);
    }
    else
    {
        _fade = 4800061;
        _dist = 0.95;
        draw_bg(spr_bg_factory_farback, 0, camx * _dist, camy * _dist);
        draw_bg_ext(spr_bg_factory_farback, 1, camx * _dist, camy * _dist, 1, 1, 0, _fade, 0.4);
    }

    if (global.bside)
    {
        _dist = 0.9;
        _scale = 0.5;
        _w = sprite_get_width(spr_bg_boomtown_farback) * _scale;
        draw_bg_ext(spr_bg_boomtown_mid, 0, camx * _dist, (camy * _dist) + 400, _scale, _scale, 0, 16777215, 1);
        draw_bg_ext(spr_bg_boomtown_mid, 0, (camx * _dist) + _w, (camy * _dist) + 400, _scale, _scale, 0, 16777215, 1);
        draw_bg_ext(spr_bg_boomtown_mid, 0, camx * _dist, (camy * _dist) + 400, _scale, _scale, 0, _fade, 0.7058823529411765);
        draw_bg_ext(spr_bg_boomtown_mid, 0, (camx * _dist) + _w, (camy * _dist) + 400, _scale, _scale, 0, _fade, 0.7058823529411765);
        _dist = 0.8;
        _scale = 1.3;
        var _alpha = 0.1;
        draw_sprite_tiled_ext(spr_bg_factory_glass, 0, camx * _dist, camy * _dist, _scale, _scale, c_white, _alpha);
        draw_sprite_tiled_ext(spr_bg_factory_glass, 1, camx * _dist, camy * _dist, _scale, _scale, c_white, _alpha);
    }

    var _dist = 0.85;
    var _x = (camx * _dist) + 1200;
    var _y = (camy * _dist) + 100;
    var _scale = 1;
    var _angle = _gear_angle;
    var _fade_alpha = 0.58;
    draw_bg_ext(spr_bg_factory_gear, _gear_ind, _x, _y, _scale, _scale, _angle, 16777215, 1);
    draw_bg_ext(spr_bg_factory_gear, _gear_ind, _x, _y, _scale, _scale, _angle, _fade, _fade_alpha);
    _angle = -_gear_angle;
    _x = (camx * _dist) + 200;
    _y = (camy * _dist) + 0;
    draw_bg_ext(spr_bg_factory_gear, _gear_ind, _x, _y, _scale, _scale, _angle, 16777215, 1);
    draw_bg_ext(spr_bg_factory_gear, _gear_ind, _x, _y, _scale, _scale, _angle, _fade, _fade_alpha);
    _dist = 0.75;
    _x = camx * _dist;
    _y = (camy * _dist) + 175;
    var _w = sprite_get_width(spr_bg_factory_belt_0);
    var _h = sprite_get_height(spr_bg_factory_belt_0);
    conveyor_ind += ((sprite_get_speed(spr_bg_factory_belt_0) / 60) * 0.5);
    conveyor_x += 0.5;

    if (conveyor_x > _w)
        conveyor_x -= _w;

    _fade_alpha = 0.15;

    for (var i = 0; i < 12; i++)
    {
        draw_bg(spr_bg_factory_belt_2, conveyor_ind, _x, _y, _fade_alpha, _fade, false);
        draw_bg_ext(spr_bg_factory_belt_2_overlay, conveyor_ind, _x, _y, 1, 1, 0, _fade, _fade_alpha);
        draw_bg(spr_bg_factory_belt_1, conveyor_ind, _x, _y, _fade_alpha, _fade, false);
        draw_bg_ext(spr_bg_factory_belt_1_overlay, conveyor_ind, _x, _y, 1, 1, 0, _fade, _fade_alpha);
        draw_bg_ext(spr_bg_factory_belt_0, conveyor_ind, _x - conveyor_x, _y + 69 + 20, 1, 0.35, 0, 16777215, 1);
        draw_bg_ext(spr_bg_factory_belt_0_overlay, conveyor_ind, _x - conveyor_x, _y + 69 + 20, 1, 0.35, 0, _fade, _fade_alpha);
        _x += _w;
    }

    _x = camx * _dist;
    _y += 330;

    for (var i = 0; i < 12; i++)
    {
        draw_bg(spr_bg_factory_belt_2, conveyor_ind, _x, _y, _fade_alpha, _fade, false);
        draw_bg_ext(spr_bg_factory_belt_2_overlay, conveyor_ind, _x, _y, 1, 1, 0, _fade, _fade_alpha);
        draw_bg(spr_bg_factory_belt_1, conveyor_ind, _x, _y, _fade_alpha, _fade, false);
        draw_bg_ext(spr_bg_factory_belt_1_overlay, conveyor_ind, _x, _y, 1, 1, 0, _fade, _fade_alpha);
        draw_bg_ext(spr_bg_factory_belt_0, conveyor_ind, _x - conveyor_x, _y + 69 + 20, 1, 0.35, 0, 16777215, 1);
        draw_bg_ext(spr_bg_factory_belt_0_overlay, conveyor_ind, _x - conveyor_x, _y + 69 + 20, 1, 0.35, 0, _fade, _fade_alpha);
        _x += _w;
    }

    _dist = 0.7;
    _x = (camx * _dist) + 440;
    _y = (camy * _dist) + 925;
    _scale = 0.9;
    _angle = _gear_angle;
    _fade_alpha = 0.33;
    draw_bg_ext(spr_bg_factory_gear, _gear_ind, _x, _y, _scale, _scale, _angle, 16777215, 1);
    draw_bg_ext(spr_bg_factory_gear, _gear_ind, _x, _y, _scale, _scale, _angle, _fade, _fade_alpha);
    _x = (camx * _dist) + 1300;
    _y = (camy * _dist) + 1030;
    _scale = 0.75;
    draw_bg_ext(spr_bg_factory_gear, _gear_ind, _x, _y, _scale, _scale, _angle, 16777215, 1);
    draw_bg_ext(spr_bg_factory_gear, _gear_ind, _x, _y, _scale, _scale, _angle, _fade, _fade_alpha);
    _dist = 0.6;
    draw_bg(spr_bg_factory_pipes, global.bside, camx * _dist, (camy * _dist) + 24);
    draw_bg_ext(spr_bg_factory_pipes, 2, camx * _dist, (camy * _dist) + 24, 1, 1, 0, _fade, 0.425);
    scr_bg_draw_tower(_fade);
    _dist = 0.45;
    var _rightxoff = 0;

    if (room == rm_round_21_1 || room == rm_round_21_2 || room == rm_round_21_3 || room == rm_round_b21_1 || room == rm_round_b21_2 || room == rm_round_b21_3)
        _rightxoff = 35;

    draw_bg(spr_bg_factory_front_left, global.bside, (camx * _dist) + 35, (camy * _dist) + 32);
    draw_bg_ext(spr_bg_factory_front_left, 2, (camx * _dist) + 35, (camy * _dist) + 32, 1, 1, 0, _fade, 0.425);
    draw_bg(spr_bg_factory_front_right, global.bside, (camx * _dist) + 35 + _rightxoff, (camy * _dist) + 32);
    draw_bg_ext(spr_bg_factory_front_right, 2, (camx * _dist) + 35 + _rightxoff, (camy * _dist) + 32, 1, 1, 0, _fade, 0.425);

    if (global.bside)
        draw_bg_ext(spr_bg_factory_b_sky, 0, camx, camy, 2, 1.5, 0, 16777215, 0.225, 0, 16777215, false);
}
