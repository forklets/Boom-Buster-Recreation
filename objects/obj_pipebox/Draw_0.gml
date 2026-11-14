var _x = x + (sprite_width / 2);
var _y = y + 24 + wings_sin;
draw_sprite_ext(anim_sprite, anim_index, x, y + wings_sin, 1, 1, 0, c_white, 1);
var _spr;

if (anim_sprite == spr_pipebox_orange)
    _spr = spr_pipebox_orange_shine;
else
    _spr = spr_pipebox_cyan_shine;

draw_sprite_ext(_spr, anim_index, x, y + wings_sin, 1, 1, 0, c_white, 0.16);
var _time = time;

if (x > (room_width / 2))
    _time -= 1.2566370614359172;

if (wings)
    wings_sin = sin(_time) * 3;
else
    wings_sin = 0;

time += 0.15;

if (wings)
{
    var _w = (sprite_width / 2) + 15;
    wing_ind += 0.35;
    draw_sprite(spr_wing, wing_ind, _x - _w, _y);
    draw_sprite_ext(spr_wing, wing_ind, _x + _w, _y, -1, 1, 0, c_white, 1);
}
