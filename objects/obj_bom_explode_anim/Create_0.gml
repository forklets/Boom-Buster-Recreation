depth = layer_get_depth("Transition");
my_fuse_snd = audio_play_sound(snd_fuse, 0, false);
timer[0] = 60;

timer_func[0] = function()
{
    if (audio_is_playing(my_fuse_snd))
        audio_stop_sound(my_fuse_snd);
    
    with (my_bom)
        event_explode();
    
    instance_destroy();
    global.freeze = 0;
};

my_pipe = noone;
