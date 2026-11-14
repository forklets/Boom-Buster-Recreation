if (audio_is_playing(snd_knife_beep))
    audio_stop_sound(snd_knife_beep);

beep_snd = audio_play_sound(snd_knife_beep, 0, true);
timer[0] = 70;

timer_func[0] = function()
{
    instance_create_layer(x, -64, "Instances_Over", obj_knife);
    
    if (audio_is_playing(beep_snd))
        audio_stop_sound(beep_snd);
    
    instance_destroy();
};

anim_init();
time = 0;
