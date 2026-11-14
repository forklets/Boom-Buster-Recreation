var _shakeX = irandom_range(-3, 3) * shake_strength;
var _shakeY = irandom_range(-3, 3) * shake_strength;
var _pal = pal_buster;

if (global.player_character[player] == 1)
    _pal = pal_bridget;

pal_swap(_pal, 0, global.palette[player] + 1);
draw_sprite_ext(anim_sprite, anim_index, x + _shakeX, y + _shakeY, facing, 1, 0, c_white, 1);
shader_reset();
