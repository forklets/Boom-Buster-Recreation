function scr_bg_outskirts()
{
    get_cams();
    var _fade;

    if (global.bside)
        _fade = 2172497;
    else
        _fade = 3677990;

    roomTop = global.room_top - 64;
    var _spd = [0.18, 0.36, 0.576];
    var _sprs = [spr_bg_outskirts_clouds_top0, spr_bg_outskirts_clouds_top1, spr_bg_outskirts_clouds_top2];

    for (var i = 0; i < 3; i++)
    {
        var _w = sprite_get_width(_sprs[i]);

        if (!exit_freeze())
            clouds_x[i] -= _spd[i];

        if (clouds_x[i] <= -_w)
            clouds_x[i] += _w;
    }

    draw_bg(spr_bg_outskirts_sky, global.bside, camx, camy);

    for (var i = 0; i < 2; i++)
    {
        var _w = sprite_get_width(spr_bg_outskirts_mountains);
        draw_sprite_ext(spr_bg_outskirts_mountains, global.bside, camx + (_w * i), camy + 200 + roomTop, 1, 1, 0, c_white, 1);
        draw_sprite_ext(spr_bg_outskirts_mountains, 2, camx + (_w * i), camy + 200 + roomTop, 1, 1, 0, _fade, 0.25);
    }

    for (var i = 0; i < 2; i++)
    {
        var _w = sprite_get_width(spr_bg_outskirts_mountains_closer);
        draw_sprite_ext(spr_bg_outskirts_mountains_closer, global.bside, ((camx * 0.92) + (_w * i)) - 100, camy + 300 + roomTop, 1, 1, 0, c_white, 1);
        draw_sprite_ext(spr_bg_outskirts_mountains_closer, 2, ((camx * 0.92) + (_w * i)) - 100, camy + 300 + roomTop, 1, 1, 0, _fade, 0.25);
    }

    dists_clouds = [0.9, 0.7925, 0.685];
    
    draw_clouds_top = function(arg0, arg1)
    {
        var _yoffs = [-10, 0, -15];
        var _sprs = [spr_bg_outskirts_clouds_top0, spr_bg_outskirts_clouds_top1, spr_bg_outskirts_clouds_top2];

        for (var i = arg0; i < arg1; i++)
        {
            var _spr = _sprs[i];

            for (var ii = 0; ii < 4; ii++)
            {
                var _w = sprite_get_width(_spr);
                draw_sprite(_spr, global.bside, (camx * dists_clouds[i]) + clouds_x[i] + (_w * ii), ((camy + _yoffs[i]) - 100) + roomTop);
            }
        }
    };
    
    draw_clouds_top(0, 3);
    towers = [];
    array_push(towers, 
    {
        spr: spr_bg_outskirts_tower0,
        scale: 0.9,
        x: 320,
        y: 1030,
        rot: 0
    });
    array_push(towers, 
    {
        spr: spr_bg_outskirts_tower1,
        scale: 0.9,
        x: 1150,
        y: 1030,
        rot: 0
    });
    array_push(towers, 
    {
        spr: spr_bg_outskirts_tower0,
        scale: 0.9,
        x: 1550,
        y: 1050,
        rot: -2
    });
    array_push(towers, 
    {
        spr: spr_bg_outskirts_tower1,
        scale: 0.9,
        x: 2200,
        y: 1030,
        rot: 0
    });
    array_push(towers, 
    {
        spr: spr_bg_outskirts_tower0,
        scale: 0.9,
        x: 3100,
        y: 1050,
        rot: -2
    });
    array_push(towers, 
    {
        spr: spr_bg_outskirts_tower0,
        scale: 0.9,
        x: 3900,
        y: 1050,
        rot: 3
    });
    array_push(towers, 
    {
        spr: spr_bg_outskirts_tower1,
        scale: 0.9,
        x: 4200,
        y: 1030,
        rot: -5
    });
    rocks = [];
    array_push(rocks, 
    {
        spr: spr_bg_outskirts_rock0,
        scale: 1,
        xscale: 1,
        x: 100,
        y: 383,
        rot: 0
    });
    array_push(rocks, 
    {
        spr: spr_bg_outskirts_rock1,
        scale: 1,
        xscale: 1,
        x: 985,
        y: 478,
        rot: 0
    });
    array_push(rocks, 
    {
        spr: spr_bg_outskirts_rock0,
        scale: 1,
        xscale: -0.95,
        x: 2340,
        y: 428,
        rot: 0
    });
    array_push(rocks, 
    {
        spr: spr_bg_outskirts_rock0,
        scale: 1,
        xscale: 1,
        x: 2600,
        y: 323,
        rot: 0
    });
    array_push(rocks, 
    {
        spr: spr_bg_outskirts_rock1,
        scale: 1,
        xscale: -0.95,
        x: 3700,
        y: 428,
        rot: 0
    });
    array_push(rocks, 
    {
        spr: spr_bg_outskirts_rock0,
        scale: 1,
        xscale: 1,
        x: 3700,
        y: 433,
        rot: -10
    });
    array_push(rocks, 
    {
        spr: spr_bg_outskirts_rock0,
        scale: 1,
        xscale: 1,
        x: 3900,
        y: 803,
        rot: 26
    });
    array_push(rocks, 
    {
        spr: spr_bg_outskirts_rock1,
        scale: 1,
        xscale: -1,
        x: 5000,
        y: 428,
        rot: 0
    });
    array_push(rocks, 
    {
        spr: spr_bg_outskirts_rock0,
        scale: 1,
        xscale: 1,
        x: 5300,
        y: 433,
        rot: 0
    });
    array_push(rocks, 
    {
        spr: spr_bg_outskirts_rock1,
        scale: 1,
        xscale: -1,
        x: 6450,
        y: 533,
        rot: 0
    });
    array_push(rocks, 
    {
        spr: spr_bg_outskirts_rock0,
        scale: 1,
        xscale: 1,
        x: 6900,
        y: 133,
        rot: 0
    });
    
    draw_rocks = function(arg0)
    {
        var _dist = 0.55;

        for (var ii = 0; ii < array_length(rocks); ii++)
        {
            var _x = (camx * _dist) + rocks[ii].x;

            if (_x < (camx - 1000) || _x > (camx + camw + 600))
                continue;

            var _spr = rocks[ii].spr;
            var _scale = rocks[ii].scale;
            var _y = camy + rocks[ii].y + roomTop;
            var _rot = rocks[ii].rot;
            var _xscale = rocks[ii].xscale;
            var _h = sprite_get_height(_spr);
            draw_sprite_ext(_spr, global.bside, _x, _y, _scale * _xscale, _scale, _rot, c_white, 1);
            draw_sprite_ext(_spr, 2, _x, _y, _scale * _xscale, _scale, _rot, arg0, 0.15);
        }
    };
    
    var _yoffs = [55, 115, 437];
    _sprs = [spr_bg_outskirts_clouds_bottom0, spr_bg_outskirts_clouds_bottom1, spr_bg_outskirts_clouds_bottom2];

    for (var i = 0; i < 3; i++)
    {
        if (i == 1)
        {
            var _dist = 0.75;

            for (var ii = 0; ii < array_length(towers); ii++)
            {
                var _x = (camx * _dist) + towers[ii].x;

                if (_x < (camx - 1200) || _x > (camx + camw + 600))
                    continue;

                var _scale = towers[ii].scale;
                _spr = towers[ii].spr;
                _h = sprite_get_height(_spr);
                var _y = camy + towers[ii].y + roomTop;
                var _rot = towers[ii].rot;
                draw_sprite_ext(_spr, global.bside, _x, _y, _scale, _scale, _rot, c_white, 1);
                draw_sprite_ext(_spr, 2, _x, _y, _scale, _scale, _rot, _fade, 0.35);
            }
        }

        var _spr = _sprs[i];
        var _w = sprite_get_width(_spr);
        var _h = sprite_get_height(_spr);

        for (var ii = 0; ii < 4; ii++)
        {
            var _xx = (camx * dists_clouds[i]) + clouds_x[i] + (_w * ii);

            if (_xx < (camx - 2000) || _xx > (camx + camw + 600))
                continue;

            draw_sprite(_spr, global.bside, _xx, ((camy + 1080) - _h) + _yoffs[i] + roomTop);
        }

        if (i == 1)
        {
            scr_bg_draw_tower(_fade);
            draw_rocks(_fade);
        }
    }
}
