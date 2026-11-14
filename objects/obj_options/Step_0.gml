event_inherited();

if (menu_selected.menu == "remap" && selected_option == 0)
{
    if (input_check_pressed_all("left") || input_check_pressed_all("right"))
    {
        menu_selected.functions[0]();
        audio_play_sound(snd_thunk, 0, false);
    }
}

if (menu == "video" || menu == "audio" || menu == "game")
{
    if (input_check_pressed_all("left") || input_check_pressed_all("right"))
    {
        if (options[selected] == "BACK" || options[selected] == "REMAP KEYBOARD" || options[selected] == "RESET PAD DEFAULT")
            exit;

        options_event[selected]();
    }
}

if (input_check_pressed_all("spin") || input_check_pressed_all("back"))
    options_event[array_length(options) - 1]();

if (menu_selected == menu_main)
{
    event_user(0);
    exit;
}

hand_ind += sprite_get_speed(spr_menu_hand) / 60;

if (hand_ind >= sprite_get_number(spr_menu_hand))
    hand_ind -= hand_ind;

if (button_time == -1)
{
    menu_move(menu_selected);

    if (input_check_pressed_all("spin") || input_check_pressed_all("back"))
    {
        input_verb_consume_all("spin");
        input_verb_consume_all("back");
        menu_selected.functions[array_length(menu_selected.options) - 1]();
    }
}

if (menu_selected.menu == "remap")
{
    if (menu_selected.options[selected_option] == "PLAYER" && button_time == -1)
    {
        if (input_check_pressed_all("jump") || input_check_pressed_all("left") || input_check_pressed_all("right"))
            menu_selected.player = !menu_selected[$ "player"];
    }

    if (button_time > 0 && button_time <= (button_wait - 5))
    {
        var _blacklist = [vk_f1, vk_f2, vk_f3, vk_f4, vk_f5, vk_f6, vk_f7, vk_f8, vk_f9, vk_f10, vk_f11, vk_f12];
        var _blacklist_press = false;

        for (var i = 0; i < array_length(_blacklist); i++)
            _blacklist_press = _blacklist_press || keyboard_check(_blacklist[i]);

        if (keyboard_check_pressed(vk_anykey) && !_blacklist_press)
        {
            var _global = "key_" + string_lower(menu_selected.options[selected_option]);
            var _struct = variable_global_get(_global);
            var _p = menu_selected[$ "player"];
            var invalid = false;

            for (i = 0; i < 2; i++)
            {
                var _inputs =
                {
                    up: global.key_up[i],
                    down: global.key_down[i],
                    left: global.key_left[i],
                    right: global.key_right[i],
                    jump: global.key_jump[i],
                    spin: global.key_spin[i],
                    dash: global.key_dash[i],
                    special: global.key_special[i],
                    crouch: global.key_crouch[i],
                    start: global.key_start[i]
                };

                var _arr = struct_get_names(_inputs);

                for (var j = 0; j < array_length(_arr); j++)
                {
                    var _key = _arr[j];
                    var _value = variable_struct_get(_inputs, _key);
                    var _current = string_lower(menu_selected.options[selected_option]);
                    show_debug_message($"{i}: {_key} = {_current}");

                    if (_value == keyboard_lastkey)
                    {
                        if (_key == _current && i == _p)
                            continue;

                        if (_current == "start")
                            continue;

                        invalid_str = $"KEY ALREADY USED BY PLAYER {i + 1}!";
                        invalid_time = invalid_wait;
                        invalid = true;
                        audio_stop_play(snd_wrong, 0, false);
                        button_time = 0;
                        break;
                    }
                }

                if (invalid)
                    break;
            }

            if (!invalid)
            {
                _struct[_p] = keyboard_lastkey;
                variable_global_set(_global, _struct);

                with (obj_persistent)
                    event_user(1);

                button_time = 0;
            }
        }
    }
}

button_time = clamp(button_time - 1, -1, button_time);
invalid_time = clamp(invalid_time - 1.5, -1, invalid_wait);

if (menu_selected.menu == "video" || menu_selected.menu == "audio" || (menu_selected.menu == "game" && selected_option == 1))
{
    if (input_check_pressed_all("left") || input_check_pressed_all("right"))
    {
        if (menu_selected.options[selected_option] == "BACK")
            exit;

        menu_selected.functions[selected_option]();
    }
}
