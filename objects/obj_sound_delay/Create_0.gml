timer[0] = -1;

timer_func[0] = function()
{
    play_sound = audio_play_sound(snd, 0, false);
    audio_sound_gain(play_sound, gain, 0);
    played = true;
};

played = false;
