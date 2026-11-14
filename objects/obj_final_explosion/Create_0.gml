played = false;
ready = false;
alarm[0] = 10;
anim_init();
var _choose = irandom_range(0, 4);
anim_sprite = global.explosions[_choose];
anim_index = 2;

event_animend = function()
{
    anim_index = sprite_get_number(anim_sprite) - 1 - 2;
};
