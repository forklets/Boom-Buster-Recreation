event_inherited();
eyes_sprite = noone;
possible_eyes = [];
sprite_stomp = spr_hamster_stomped;
sprite_spun = spr_hamster_spun;
conveyors = false;
walkspd = 0;

event_animend = function()
{
    var _spr = anim_sprite;
    
    if (_spr == spr_hamster_jump)
        anim_index = 1;
    else if (_spr == spr_hamster_land)
        anim_play(spr_hamster);
};

event_jump = function()
{
    if (!on_ground())
        exit;
    
    vspd = -jump_strength;
    anim_play(spr_hamster_jump);
};

jump_strength = 17;
grav = 0.68;

event_floor = function()
{
    vspd = 0;
    anim_play(spr_hamster_land);
};
