ds_map_destroy(global.map_path_data);

if (room == rm_tutorial_7)
{
    global.combo_meter = 0;
    global.bubble = false;
}

if (array_contains(global.stages_final, room))
    exit;

for (var i = 0; audio_exists(i); i++)
{
    if (audio_sound_get_audio_group(i) != bgm_bonus && audio_is_playing(i))
        audio_stop_sound(i);
}
