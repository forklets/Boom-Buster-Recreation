if (!audio_is_playing(bgm) && !audio_is_playing(bgm_fakeout))
{
    if (audio_is_playing(global.bgmPlay))
        audio_stop_sound(global.bgmPlay);
    
    if (instance_exists(obj_stagestart) && obj_stagestart.boss_cutscene)
        global.bgmPlay = audio_play_sound(bgm_fakeout, 0, true);
    else
        global.bgmPlay = audio_play_sound(bgm, 0, true);
}

final_ready = true;
