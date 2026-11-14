hand_ind += sprite_get_speed(spr_menu_hand) / 60;

if (hand_ind >= sprite_get_number(spr_menu_hand))
    hand_ind -= hand_ind;

menu_move(menu_selected);

if (input_check_pressed_all("spin"))
{
    input_verb_consume("spin");
    menu_selected.functions[array_length(menu_selected.options) - 1]();
    audio_play_sound(snd_spin, 0, false);
}

var _str;

if (global.deadzone == 0)
    _str = "LOW";
else if (global.deadzone == 1)
    _str = "NORMAL";
else if (global.deadzone == 2)
    _str = "HIGH";

menu_game.options[1] = $"PAD DEADZONE: {_str}";

if (menu_selected == menu_game && selected_option == 1)
{
    var _xAxis = input_check_pressed_all("right") - input_check_pressed_all("left");

    if (_xAxis != 0)
    {
        audio_play_sound(snd_nab, 0, false);
        global.deadzone += _xAxis;
        global.deadzone = clamp(global.deadzone, 0, 2);
        ini_open("options.ini");
        ini_write_real("OPTIONS", "Gamepad Deadzone", global.deadzone);
        ini_close();
    }
}

_str = $"{obj_persistent.resW[global.resolution]}x{obj_persistent.resH[global.resolution]}";
menu_video.options[1] = $"RESOLUTION: {_str}";

if (menu_selected == menu_video && selected_option == 1)
{
    _xAxis = input_check_pressed_all("right") - input_check_pressed_all("left");

    if (_xAxis != 0)
    {
        audio_play_sound(snd_nab, 0, false);
        global.resolution -= _xAxis;
        global.resolution = clamp(global.resolution, 0, 4);

        with (obj_persistent)
            resize_resolution();

        ini_open("options.ini");
        ini_write_real("OPTIONS", "Resolution", global.resolution);
        ini_write_real("OPTIONS", "Fullscreen", window_get_fullscreen());
        ini_close();
    }
}

menu_video.options[2] = $"TEXTURE FILTER:  {bool_onoff(global.texfilter)}";
menu_video.options[3] = $"VSYNC: {bool_onoff(global.vsync)}";

menu_audio.options[0] = $"MASTER VOL: {global.vol_master * 100}%";
menu_audio.options[1] = $"BGM VOL: {global.vol_bgm * 100}%";
menu_audio.options[2] = $"SFX VOL: {global.vol_sfx * 100}%";

if (menu_selected == menu_audio && selected_option < 3)
{
    _xAxis = input_check_pressed_all("right") - input_check_pressed_all("left");

    if (_xAxis != 0)
    {
        if (selected_option != 1)
            audio_play_sound(snd_nab, 0, false);

        if (selected_option == 0)
            global.vol_master += 0.1 * _xAxis;
        else if (selected_option == 1)
            global.vol_bgm += 0.1 * _xAxis;
        else if (selected_option == 2)
            global.vol_sfx += 0.1 * _xAxis;

        global.vol_master = clamp(global.vol_master, 0, 1);
        global.vol_bgm = clamp(global.vol_bgm, 0, 1);
        global.vol_sfx = clamp(global.vol_sfx, 0, 1);
        global.vol_master = round(global.vol_master * 10) / 10;
        global.vol_bgm = round(global.vol_bgm * 10) / 10;
        global.vol_sfx = round(global.vol_sfx * 10) / 10;

        with (obj_persistent)
            set_audio();

        ini_open("options.ini");
        ini_write_real("OPTIONS", "Master Volume", global.vol_master);
        ini_write_real("OPTIONS", "BGM Volume", global.vol_bgm);
        ini_write_real("OPTIONS", "SFX Volume", global.vol_sfx);
        ini_close();
    }
}
