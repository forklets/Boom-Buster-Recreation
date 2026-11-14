timer[2] = 150;

timer_func[2] = function()
{
    can_go = true;
};

timer[3] = 30;

timer_func[3] = function()
{
    glyph_scale_num = !glyph_scale_num;
    timer[3] = 30;
};

can_go = false;
alpha = 0;
audio_play_sound(snd_revenge, 0, false);
glyph_scale = 1;
glyph_scale_num = 0;
