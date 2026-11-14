event_inherited();
stompable = true;
spinnable = true;
sprite_idle = spr_pinky_idle;
sprite_move = spr_pinky_run;
anim_play(sprite_move);
ledge_turn = true;
sprite_spun = spr_pinky_spun;
sprite_stomp = spr_pinky_stomped;
walkspd = 3;
shoot_delay = 180;
timer[0] = shoot_delay - 30;

timer_func[0] = function()
{
    if (!on_ground())
        timer[0] = 10;
    
    anim_play(spr_pinky_idle);
    timer[1] = 30;
    hspd = 0;
};

timer[1] = -1;

timer_func[1] = function()
{
    anim_play(spr_pinky_prep);
};

timer[2] = -1;

timer_func[2] = function()
{
    anim_play(spr_pinky_run);
    hspd = walkspd * facing;
    timer[0] = shoot_delay;
};

event_animend = function()
{
    var _spr = anim_sprite;
    
    if (_spr == spr_pinky_prep)
    {
        anim_play(spr_pinky_shoot);
        var _pellet = instance_create_layer(x + (59 * facing), y - 54, "Instances_Over", obj_pinky_pellet);
        _pellet.hspd = facing * 6;
    }
    else if (_spr == spr_pinky_shoot)
    {
        anim_play(spr_pinky_idle);
        timer[2] = 30;
    }
};
