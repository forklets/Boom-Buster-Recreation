if (!display)
{
    timer_logic(1);
    exit;
}

var _selected = selected;
var _xAxis = input_check_pressed_all("right") - input_check_pressed_all("left");

if (deac)
    _xAxis = 0;

selected += _xAxis;
selected = clamp(selected, 0, 1);

if (selected != _selected)
{
    var _snd = audio_stop_play(snd_splat, 0, false);
    audio_sound_pitch(_snd, 1.4);
}

if (!deac && input_check_pressed("jump"))
{
    audio_play_sound(snd_kaching, 0, false);
    deac = true;
    global.player_character[0] = selected;
    timer[0] = 20;
}

timer_logic(0);
timer_logic(1);
hue += 1.5;
