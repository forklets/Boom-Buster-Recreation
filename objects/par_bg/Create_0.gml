bg_script = noone;
bg_elements = [];

draw_bg_overlay = function(arg0, arg1)
{
    draw_set_alpha(arg1);
    draw_rectangle_color(0, 0, room_width, room_height, arg0, arg0, arg0, arg0, false);
    draw_set_alpha(1);
};
