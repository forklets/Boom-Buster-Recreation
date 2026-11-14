timer_logic(2);
timer_logic(3);

if (can_go)
    alpha = approach(alpha, 1, 1/30);

if (can_go && input_check_pressed_all("jump"))
{
    audio_play_sound(snd_thunk, 0, false);
    room_goto_fade(rm_title, 120);
    can_go = false;
    timer[3] = -1;
}

if (keyboard_check_pressed(ord("R")))
    room_restart();
