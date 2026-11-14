function combo_play_sound()
{
    if (audio_is_playing(lastComboSnd))
        audio_stop_sound(lastComboSnd);
    
    lastComboSnd = audio_play_sound(asset_get_index($"snd_combo{min(combo, 8)}"), 0, 0);
    
    if (global.voice_clips)
    {
        var _voices;
        
        if (global.player_character[player] == 0)
            _voices = [voice_buster_wicked, voice_buster_notbad, voice_buster_alright, voice_buster_prettygood];
        else
            _voices = [voice_bridget_okicu, voice_bridget_nice, voice_bridget_okay, voice_bridget_alright, voice_bridget_notbad];
        
        var _pick = irandom_range(0, array_length(_voices) - 1);
        var _voice = _voices[_pick];
        
        for (var i = 0; i < array_length(_voices); i++)
        {
            if (audio_is_playing(_voices[i]))
                audio_stop_sound(_voices[i]);
            
            with (obj_sound_delay)
            {
                if (array_contains(_voices, snd))
                    instance_destroy();
            }
        }
        
        if (combo >= 4)
            lastVoiceSnd = audio_play_sound_delay(_voice, 22);
        
        if (combo >= 5)
            scr_get_achievement("COMBO_5");
        else if (combo >= 7)
            scr_get_achievement("COMBO_7");
    }
}
