event_inherited();
col = 0;

event_explode = function()
{
    audio_play_sound(snd_wrong, 0, false);
    instance_destroy();
};

worth = 7;
life = 840;
limited_life = true;
alarm[0] = 1;
timer_sparkle = array_length(timer);
timer[timer_sparkle] = 5;

timer_func[timer_sparkle] = function()
{
    var _x = x;
    var _y = y - 32;
    _x += irandom_range(-30, 30);
    _y += irandom_range(-30, 30);
    var _fx = instance_create_layer(_x, _y, "Particles_Over", obj_fx);
    
    with (_fx)
        anim_play(spr_fx_sparkle_tiny_white);
    
    timer[timer_sparkle] = irandom_range(10, 15);
};

pipe_add_bom = false;
