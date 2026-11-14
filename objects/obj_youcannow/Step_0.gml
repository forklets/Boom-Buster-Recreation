timer_logic(0);
timer_logic(1);
timer_logic(2);
timer_logic(3);

if (in)
    alpha = approach(alpha, 1, 1/30);

if (can_go && input_check_pressed_all("jump"))
{
    audio_play_sound(snd_thunk, 0, false);
    room_goto_fade(rm_revenge_unlocked, 120);
    can_go = false;
    timer[3] = -1;
}
