var _xshake = irandom_range(-1, 1);
var _yshake = irandom_range(-1, 1);
scale = 1.2 + (sin(pi * time) * 0.2);
draw_sprite_ext(anim_sprite, anim_index, x + _xshake, y + _yshake, scale, scale, 0, c_white, 1);
