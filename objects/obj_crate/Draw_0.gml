draw_sprite_ext(anim_sprite, anim_index, x, y + wings_sin, image_xscale, image_yscale, angle, image_blend, image_alpha);

if (wings)
{
    var _w = bbox_right - bbox_left;
    var _h = bbox_bottom - bbox_top;
    var _x = x + (_w / 2);
    var _y = y - (_h / 2) - 12;
    var _wingW = wing_width;
    draw_sprite(spr_wing, wing_ind, _x - _wingW, _y + wings_sin);
    draw_sprite_ext(spr_wing, wing_ind, _x + _wingW, _y + wings_sin, -1, 1, 0, c_white, 1);
}
