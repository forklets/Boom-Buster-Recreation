function scr_bg_mall()
{
    get_cams();
    clouds_x -= 0.12;
    var _yoff = 0;

    if (room == rm_round_8)
        _yoff = -107;

    draw_bg(spr_bg_mall_sky, 0, camx, camy + _yoff);
    draw_bg_ext(spr_bg_mall_sky, global.bside, camx, camy + _yoff, undefined, undefined, undefined, undefined, 0.9);
    draw_bg_ext(spr_bg_boomtown_clouds, 0, camx + clouds_x, camy + 12 + _yoff, 1, 1, 0, 16777215, 0.5, undefined, undefined, true);
    var _fade;

    if (global.bside)
        _fade = 16768943;
    else
        _fade = 12045479;

    draw_bg(spr_bg_mall, 0, camx * 0.9, camy + _yoff);
    draw_bg_ext(spr_bg_mall, 1, camx * 0.9, camy + _yoff, 1, 1, 0, _fade, 0.4);
    var _npcs = [];

    with (obj_bg_mall_npc)
        array_push(_npcs, id);
    
    var _sort = function(arg0, arg1)
    {
        return arg0.depth - arg1.depth;
    };
    
    array_sort(_npcs, _sort);

    for (var i = 0; i < array_length(_npcs); i++)
    {
        with (_npcs[i])
        {
            var _x = (other.camx * 0.9) + x;
            var _y = other.camy + 403;
            var _scale = 0.85;
            draw_bg_ext(spr_bg_mall_guy, image_index, _x, _y + _yoff + y, _scale * facing, _scale, 0, 16777215, 1);
            draw_bg_ext(spr_bg_mall_guy_overlay, image_index, _x, _y + _yoff + y, _scale * facing, _scale, 0, _fade, 0.4);
        }
    }

    draw_bg(spr_bg_mall_bars, 0, camx * 0.9, camy + _yoff);
    draw_bg_ext(spr_bg_mall_bars, 1, camx * 0.9, camy + _yoff, 1, 1, 0, _fade, 0.4);

    if (!instance_exists(obj_bg_mall_npc_spawner))
        instance_create_layer(0, 0, layer, obj_bg_mall_npc_spawner);

    scr_bg_draw_tower(_fade);

    if (global.bside)
    {
        if (!instance_exists(obj_tower))
        {
            draw_bg_ext(spr_bg_xmas_1, 0, camx * 0.725, camy * 0.725, 1, 1, 0, 16777215, 1);
            draw_bg_ext(spr_bg_xmas_1, 1, camx * 0.725, camy * 0.725, 1, 1, 0, _fade, 0.515);
        }

        _yoff = 0;

        if (room == rm_mall_extrab1)
            _yoff = 95;

        draw_bg(spr_bg_xmas, 0, camx * 0.525, (camy * 0.525) + _yoff);
        draw_bg_ext(spr_bg_xmas, 1, camx * 0.525, (camy * 0.525) + _yoff, 1, 1, 0, _fade, 0.46);
    }
}
