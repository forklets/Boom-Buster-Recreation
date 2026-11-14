if (instance_exists(obj_title_extras))
{
    draw_set_alpha(0.8);
    draw_rectangle_color(0, 0, 1920, 1080, c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
}

var _x;

if (global.playground || room == rm_title)
    _x = 960;
else
    _x = 704;

var _y = 540;
draw_sprite_ext(sprite_index, image_index, _x, _y, 1, 1, 0, c_white, 1);
