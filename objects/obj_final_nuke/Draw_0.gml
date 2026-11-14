var _shake = 3;
var _xshake = irandom_range(-_shake, _shake);
var _yshake = irandom_range(-_shake, _shake);
draw_sprite_ext(spr_final_nuke, anim_index, x + _xshake, y + _yshake, 1, 1, 0, c_white, image_alpha);
var _spr;

if (global.player_character[0] == 0)
    _spr = spr_final_nuke_bridget;
else
    _spr = spr_final_nuke_buster;

draw_sprite_ext(_spr, anim_index, x + _xshake, y + _yshake, 1, 1, 0, c_white, image_alpha);
