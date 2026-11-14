var _alpha = image_alpha;

if (obj_editor.edit_mode)
    _alpha = 1;

var _off = (xstart / 64) * 0.7853981633974483;
_off += ((ystart / 64) * 0.7853981633974483);
var _xscale = 1 + (sin((current_time / 275) + _off) * 0.04);
var _yscale = 1 - (sin((current_time / 275) + _off) * 0.04);
draw_sprite_ext(anim_sprite, anim_index, x, y + yoff, _xscale, _yscale, 0, c_white, _alpha * 0.8);
draw_sprite_ext(spr_orb_outline, anim_index, x, y + yoff, _xscale, _yscale, 0, c_white, _alpha);
