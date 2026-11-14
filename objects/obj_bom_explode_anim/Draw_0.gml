get_cams();
var _zoom = obj_controller.zoom;
var _col = 0;
draw_set_alpha(0.5);
draw_rectangle_color(camx, camy, camx + (1920 * _zoom), camy + (1080 * _zoom), _col, _col, _col, _col, false);
draw_set_alpha(1);

with (my_bom)
{
    xscale_squish = 1;
    yscale_squish = 1;
    get_cams(0);
    event_perform(ev_draw, ev_draw_normal);
}

with (my_pipe)
{
    get_cams(0);
    pal_swap(pal_pipe, global.colorblind, col + 1);
    draw_sprite_ext(anim_sprite, anim_index, x, y, 1, 1, 0, c_white, 1);
    shader_reset();
}
