anim_init();

event_animend = function()
{
    var _anim = anim_sprite;
    
    if (_anim == spr_bouncepounce_anim)
        anim_play(spr_bouncepounce);
};

event_bounce = function(arg0)
{
    anim_play(spr_bouncepounce_anim);
    audio_play_sound(snd_bounce, 0, 0);
    
    with (arg0)
    {
        bounce_blocks = other.bounce_height;
        bounce_blocks_hold = other.bounce_height;
        event_bounce();
    }
};
