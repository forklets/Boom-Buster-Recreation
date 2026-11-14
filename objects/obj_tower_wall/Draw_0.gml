var _amnt = 24;
var _xshake = irandom_range(-shake, shake) * _amnt;
var _yshake = irandom_range(-shake, shake) * _amnt;
var _spr;

if (x < (room_width / 2))
    _spr = spr_tower_wall_left;
else
    _spr = spr_tower_wall_right;

draw_sprite_ext(_spr, 0, x + _xshake, y + _yshake, 1, 1, 0, c_white, image_alpha);
