screen_shake(32, 32);
fade_alpha = approach(fade_alpha, 1, 0.01);
timer_delay = approach(timer_delay, 3, 0.06);

if (fade_black)
{
    fade_black_alpha = approach(fade_black_alpha, 1, 0.01);
    
    if (fade_black_alpha == 1 && timer[2] == -1)
        timer[2] = 20;
}

if (fade_alpha == 1 && timer[1] == -1)
    timer[1] = 40;

timer_logic(0);
timer_logic(1);
timer_logic(2);
