var _amnt;

if (ending_index == 0)
    _amnt = 2;
else
    _amnt = choose(1, 2);

var _xshake = irandom_range(-_amnt, _amnt);
var _yshake = irandom_range(-_amnt, _amnt);
draw_sprite(bg_sprite, 0, 0, 0);
draw_sprite(bg_sprite, 0, _xshake, _yshake);

if (ending_index == 0)
{
    var __xshake = irandom_range(-3, 3);
    draw_sprite(spr_cutscene_ending_tower, 0, _xshake + __xshake, _yshake + tower_sink);
    draw_sprite(spr_cutscene_ending_smoke, smoke_ind, _xshake, _yshake);
    draw_sprite(spr_cutscene_ending_gradient, 0, 0, 0);
}

draw_sprite(anim_sprite, anim_index, _xshake, _yshake);
draw_set_alpha(fade);
draw_rectangle_color(0, 0, 1920, 1080, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);
