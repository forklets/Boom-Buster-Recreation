if (!instance_exists(id))
    exit;

var _zoom = obj_controller.zoom;
var _camx = camera_get_view_x(view_camera[0]);
var _camy = camera_get_view_y(view_camera[0]);

if (!surface_exists(surf))
    surf = surface_create(1408, 1080);

surface_set_target(surf);
draw_set_color(c_black);
draw_rectangle(0, 0, 1408, 1080, false);
draw_set_color(c_white);
gpu_set_blendmode(bm_subtract);

with (par_player)
{
    var _x = (x * _zoom) - (_camx * _zoom);
    var _y = (y * _zoom) - (_camy * _zoom);
    draw_circle(_x, _y - (40 * _zoom), other.player_radius, false);
}

with (obj_player_death)
{
    if (visible)
    {
        var _x = (x * _zoom) - (_camx * _zoom);
        var _y = (y * _zoom) - (_camy * _zoom);
        draw_circle(_x, _y - (40 * _zoom), other.player_radius, false);
    }
}

with (obj_bom)
{
    var _x = (x * _zoom) - (_camx * _zoom);
    var _y = (y * _zoom) - (_camy * _zoom);
    draw_circle(_x, _y - (40 * _zoom), other.bom_radius, false);
}

with (obj_fireball)
{
    var _x = (x * _zoom) - (_camx * _zoom);
    var _y = (y * _zoom) - (_camy * _zoom);
    draw_circle(_x, _y * _zoom, other.fireball_radius, false);
}

with (obj_lightning)
{
    var _x = (x * _zoom) - (_camx * _zoom);
    var _y = (y * _zoom) - (_camy * _zoom);
    shader_set(sha_flash);
    draw_sprite_ext(anim_sprite, anim_index, _x, _y * _zoom, 1, 1, 0, c_white, image_alpha);
    shader_reset();
}

with (obj_knife_indicator)
{
    var _xbefore = x;
    var _ybefore = y;
    x = (x * _zoom) - (_camx * _zoom);
    y = (y * _zoom) - (_camy * _zoom);
    shader_set(sha_flash);
    event_perform(ev_draw, ev_draw_normal);
    shader_reset();
    x = _xbefore;
    y = _ybefore;
}

with (obj_knife)
{
    var _xbefore = x;
    var _ybefore = y;
    x = (x * _zoom) - (_camx * _zoom);
    y = (y * _zoom) - (_camy * _zoom);
    shader_set(sha_flash);
    event_perform(ev_draw, ev_draw_normal);
    shader_reset();
    x = _xbefore;
    y = _ybefore;
}

gpu_set_blendmode(bm_normal);
surface_reset_target();
draw_set_alpha(darkness * flicker);
draw_surface(surf, global.app_xoff, 0);
draw_set_alpha(1);
