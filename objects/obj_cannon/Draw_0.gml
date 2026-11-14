var _x = x;
var _y = y;

if (image_angle == 0)
    _y += yoff;
else if (image_angle == 180)
    _y -= yoff;
else if (image_angle == 90)
    _x += yoff;
else if (image_angle == 270)
    _x -= yoff;

if (image_angle == 90 || image_angle == 270)
    _y -= 64;
else if (image_angle == 45 || image_angle == 315)
    _y -= 32;

draw_sprite_ext(anim_sprite, anim_index, _x, _y, scale, scale, image_angle, c_white, 1);
