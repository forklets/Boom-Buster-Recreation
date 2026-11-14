var _sprs = [spr_spike_impaled_buster, spr_spike_impaled_bridget];
var _spr = _sprs[char];
var _pal_sprite = [pal_buster, pal_bridget];
var _pal_index = palette + 1;
pal_swap(_pal_sprite[char], 0, _pal_index);
var _facing_xoff = 0;

if (facing == -1)
    _facing_xoff = 64;

draw_sprite_ext(_spr, anim_index, x + _facing_xoff, y, facing, 1, 0, c_white, 1);
shader_reset();
