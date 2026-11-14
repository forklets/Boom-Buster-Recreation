timer[0] = 120;

timer_func[0] = function()
{
    in = true;
    audio_play_sound(snd_youcannow, 0, 0);
    timer[1] = 60;
    timer[3] = 40;
};

timer[1] = -1;

timer_func[1] = function()
{
    audio_play_sound(voice_bridget_ohok, 0, false);
    timer[2] = 60;
};

timer[2] = -1;

timer_func[2] = function()
{
    can_go = true;
};

timer[3] = -1;

timer_func[3] = function()
{
    glyph_scale_num = !glyph_scale_num;
    timer[3] = 30;
};

can_go = false;
alpha = 0;
in = false;
glyph_scale = 1;
glyph_scale_num = 0;
