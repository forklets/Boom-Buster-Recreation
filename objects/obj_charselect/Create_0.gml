selected = global.player_character[0];
hue = 0;
deac = false;
timer[0] = -1;

timer_func[0] = function()
{
    var _yay, _mad;
    
    if (global.player_character[0] == 0)
    {
        _yay = voice_buster_alright;
        _mad = voice_bridget_umok_short;
    }
    else
    {
        _yay = voice_bridget_alright;
        _mad = voice_buster_fuckyamudda;
    }
    
    var _snd = audio_play_sound(_yay, 0, false);
    audio_sound_gain(_snd, 0.35, 0);
    audio_play_sound_delay(_mad, 40, 0.25);
    timer[1] = 80;
};

timer[1] = -1;

timer_func[1] = function()
{
    room_goto_triangles(global.next_room, 90);
};

display = true;

if (global.players > 1)
{
    timer[1] = 1;
    display = false;
}
