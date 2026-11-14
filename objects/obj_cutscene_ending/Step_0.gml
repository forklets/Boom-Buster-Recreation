event_inherited();

if (bw_fade)
    bw_alpha = approach(bw_alpha, 1, 0.016666666666666666);

if (global.debug)
{
    var _scroll = 75;
    
    if (mouse_wheel_up())
        y += _scroll;
    
    if (mouse_wheel_down())
        y -= _scroll;
}

if (final_y != undefined && y <= (-final_y + 200) && !fade_out)
{
    fade_out = true;
    audio_sound_gain(bgm_play, 0, 2500);
    timer[2] = 300;
}

if (fade_out)
    credits_alpha = approach(credits_alpha, 0, 1/120);

if (credits_roll)
    y -= 1.75;

timer_logic(2);
timer_logic(3);
timer_logic(4);
