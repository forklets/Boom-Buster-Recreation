draw_set_alpha(fade_alpha);
draw_rectangle(0, 0, 1920, 1080, false);
draw_set_alpha(1);

with (obj_fx)
    event_perform(ev_draw, ev_draw_normal);

draw_set_alpha(fade_black_alpha);
draw_set_color(c_white);
draw_rectangle(0, 0, 1920, 1080, false);
draw_set_color(c_white);
draw_set_alpha(1);

with (obj_round_clear)
    event_user(0);

with (obj_round_clear_select)
{
    draw_set_alpha(0.55);
    draw_rectangle_color(0, 0, 1920, 1080, c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
    event_user(1);
}
