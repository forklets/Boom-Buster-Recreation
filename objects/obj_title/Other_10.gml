if (audio_is_playing(global.bgm_play))
{
    var _bgm = global.bgm_play;
    
    if (audio_is_playing(_bgm) && bpm != -4)
    {
        var _pos = audio_sound_get_track_position(_bgm);
        var _beat = false;
        
        while (((beats - 1) * time_bpm_to_seconds(bpm)) >= _pos)
        {
            beats--;
            
            if (((beats - 1) * time_bpm_to_seconds(bpm)) < _pos)
                beats--;
        }
        
        while (_pos >= (time_bpm_to_seconds(bpm) * beats))
        {
            beats++;
            _beat = true;
        }
        
        if (_beat)
        {
            event_beat();
            
            if ((beats % 2) == off_beat)
                event_beat_double();
        }
    }
}

logo_bounce_normal = 0.95;
logo_bounce_double = 0.9;
logo_beat_percent = approach(logo_beat_percent, 1, 0.055);
logo_scale_beat = use_curve(acurv_basics, logo_beat_percent, "bounce", logo_bounce_amnt, 1);
