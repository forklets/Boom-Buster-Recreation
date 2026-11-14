var _col;

if (global.colorblind)
    _col = sprite_get_width(pal_bom_cage) - 1;
else
    _col = 0;

pal_swap(pal_bom_cage, global.colorblind, _col);
var _x = x;
var _y = y;

if (!instance_exists(cage_anim))
    draw_sprite_ext(anim_sprite, anim_index, _x, _y, 1.1, 1.1, 0, c_white, 1);

shader_reset();
