timer_logic(0);

if (go)
    exit;

var _selected = selected;
yAxis = input_check_pressed_all("down") - input_check_pressed_all("up");
selected += yAxis;

if (selected < 0)
    selected = 0;

if (selected > 1)
    selected = 1;

if (selected != _selected)
{
    var _snd = audio_play_sound(snd_nab, 0, false);
    audio_sound_gain(_snd, 0.7, 0);
    audio_sound_pitch(_snd, 0.9);
    shake = 4;
}

if (input_check_pressed("jump"))
{
    audio_play_sound(snd_kaching, 0, false);
    timer[0] = 120;
    go = true;
    
    if (selected == 0)
        my_room = rm_tutorial_1;
    else if (global.bside)
        my_room = rm_round_b1;
    else
        my_room = rm_round_1;
}
