var _pos = audio_sound_get_track_position(sound_play);

if (_pos >= 5.75 && !go)
{
    go = true;
    audio_sound_gain(global.bgmPlay, 0.4, 2500);
    timer[0] = 135;
}

if (_pos >= 7.3)
{
    if (global.bside)
        room_goto(rm_final_b);
    else
        room_goto(rm_final);
    
    audio_sound_gain(global.bgmPlay, 1, 0);
    exit;
}

if (audio_is_playing(sound_play) && array_length(flashes) > 0)
{
    if (_pos >= flashes[0])
    {
        event_flash();
        array_delete(flashes, 0, 1);
    }
}

var _to = 1.2;
var _spd = 40;

if (flash)
{
    flash_alpha = approach(flash_alpha, 0, _to / _spd);
    
    if (flash_alpha == 0)
        flash = false;
}
else
{
    flash_alpha = approach(flash_alpha, _to, _to / _spd);
}
