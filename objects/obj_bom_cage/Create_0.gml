anim_init();
bom_inside = noone;
cage_anim = noone;

event_animend = function()
{
    var _spr = anim_sprite;
    
    if (_spr == spr_bom_cage_open)
        anim_play(spr_bom_cage_idle);
};

col = -1;
flash_time_fast = 0.1;
flash_time = 0.35;
flash = 0;
