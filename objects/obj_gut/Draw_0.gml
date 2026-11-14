var _palswap = false;

if (anim_sprite == spr_gut_draw && anim_index == 9)
    _palswap = true;

_palswap = true;

if (_palswap)
    pal_swap(palettes[char], 0, global.palette[global.player_character[player]] + 1);

draw_sprite_ext(anim_sprite, anim_index, x, y + yoff, facing, 1, angle, c_white, image_alpha);

if (_palswap)
    shader_reset();
