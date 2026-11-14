event_inherited();

if (global.bubble)
{
    event_cash();
}
else
{
    audio_play_sound(snd_shield, 0, 0);
    var _voice = voice_buster_laugh;
    
    if (global.player_character[0] == 1)
        _voice = voice_bridget_heheyay;
    
    if (global.voice_clips)
        audio_queue(_voice, 35, true, true);
    
    global.bubble = true;
    instance_destroy();
}
