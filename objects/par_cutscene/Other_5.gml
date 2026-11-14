if (audio_is_playing(bgm_play))
    audio_stop_sound(bgm_play);

if (!array_contains(global.save.cutscenes_watched, cutscene))
    array_push(global.save.cutscenes_watched, cutscene);
