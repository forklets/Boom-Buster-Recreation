get_cams();
var _zoom = obj_controller.zoom;
draw_set_alpha(alpha);
draw_rectangle(camx, camy, camx + (1920 * _zoom), camy + (1080 * _zoom), false);
draw_set_alpha(1);

with (obj_lightning)
    draw_sprite_ext(anim_sprite, anim_index, x, y, 1, 1, 0, c_black, image_alpha);

with (par_player)
{
    lightning_alpha = other.alpha;
    var _blend = image_blend;
    image_blend = c_black;
    event_perform(ev_draw, ev_draw_normal);
    image_blend = _blend;
}

with (obj_player_death_zap)
    event_perform(ev_draw, ev_draw_normal);
