global.deaths = 0;
audio_stop_all();
global.bgmPlay = audio_play_sound(bgm_finale, 0, true);
audio_sound_gain(global.bgmPlay, 0, 0);
audio_sound_set_track_position(global.bgmPlay, 81.5);
sound_play = audio_play_sound(snd_gotime, 0, false);
flashes = [0, 1.95, 3.854, 5.715];
flash_count = 0;
flash = false;
flash_alpha = 1;

event_flash = function()
{
    flash_count++;
    flash = true;
    
    if (flash_count == 3)
        gotime_ind = 1;
};

gotime_ind = 0;
go = false;
