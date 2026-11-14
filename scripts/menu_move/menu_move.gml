function menu_move(_menu)
{
    var _yAxis = input_check_pressed_all("down") - input_check_pressed_all("up");

    if (_yAxis != 0)
    {
        audio_play_sound(snd_nab, 0, false);
        selected_option += _yAxis;

        if (selected_option > (array_length(_menu.options) - 1))
            selected_option = 0;

        if (selected_option < 0)
            selected_option = array_length(_menu.options) - 1;
    }

    if (input_check_pressed_all("jump"))
    {
        audio_play_sound(snd_thunk, 0, false);
        _menu.functions[selected_option]();
        input_verb_consume("jump");
    }
}
