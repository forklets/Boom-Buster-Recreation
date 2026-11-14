timer_logic(0);

if (played && !audio_is_playing(play_sound))
    instance_destroy();
