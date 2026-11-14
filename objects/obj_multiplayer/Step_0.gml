var _pressed = false;
var _kb = false;
var _gp = -1;

if (state >= 2)
{
    if (input_check_pressed_all("jump"))
        global.players = 2;
    
    fade += (delta_time / 1000000);
    
    if (fade >= 1 && instance_exists(obj_paused))
    {
        with (obj_paused)
            options_event[0]();
        
        with (obj_player)
        {
            var _xpos = xstart - 64;
            var _ypos = ystart;
            
            if (array_contains(global.stages_final, room) || array_contains(global.stages_final_scroll, room))
            {
                _xpos = x;
                _ypos = y;
            }
            
            var _inst = instance_create_layer(_xpos, _ypos, layer, obj_player2);
            _inst.invulnerable = true;
            _inst.timer[timer_invulnerable_flash] = 5;
            _inst.invulnerable_flash = true;
            _inst.timer[timer_become_vulnerable] = 120;
        }
        
        global.players = 2;
        instance_destroy();
        exit;
    }
    
    if (fade >= 2.5)
    {
        global.players = 2;
        room_goto(rm_final);
    }
    
    exit;
}

if (keyboard_check_pressed(vk_anykey))
{
    _pressed = true;
    _kb = true;
    _gp = -1;
    input_source_mode_set(0);
    input_source_set(__input_global().__source_keyboard, state);
}

var _pads = gamepad_get_device_count();

for (var i = 0; i < _pads; i++)
{
    if (gamepad_is_connected(i))
    {
        for (var btn = 32769; btn < 32810; btn++)
        {
            if (gamepad_button_check_pressed(i, btn) && i != player[0].device_id)
            {
                _pressed = true;
                _gp = i;
                _kb = false;
                input_source_mode_set(0);
                input_source_set(__input_global().__source_gamepad[i], state);
                break;
            }
        }
        
        if (_pressed)
            break;
    }
}

if (_pressed)
{
    if (_kb)
    {
        player[state].keyboard_mouse = true;
        player[state].device_name = "Keyboard";
    }
    else if (_gp != -1)
    {
        player[state].device_id = _gp;
        player[state].device_name = input_gamepad_get_description(_gp);
    }
    
    audio_play_sound(snd_bell, 0, false);
    state++;
    _pressed = false;
    _kb = false;
    _gp = -1;
}

if (state >= 2)
{
    audio_play_sound(snd_coin, 0, false);
    
    if (!player[0].keyboard_mouse && player[1].keyboard_mouse)
    {
        var _inputs = 
        {
            up: global.key_up[0],
            down: global.key_down[0],
            left: global.key_left[0],
            right: global.key_right[0],
            jump: global.key_jump[0],
            spin: global.key_spin[0],
            dash: global.key_dash[0],
            special: global.key_special[0],
            crouch: global.key_crouch[0],
            start: global.key_start[0]
        };
        var _arr = struct_get_names(_inputs);
        
        for (var j = 0; j < array_length(_arr); j++)
        {
            var _key = _arr[j];
            var _value = variable_struct_get(_inputs, _key);
            input_binding_set(_key, input_binding_key(_value), 1, undefined, "keyboard_and_mouse");
        }
        
        input_binding_set("crouch", input_binding_key(global.key_down[0]), 1, undefined, "keyboard_and_mouse");
    }
    else if (player[0].keyboard_mouse && player[1].keyboard_mouse)
    {
        input_source_share(__input_global().__source_keyboard, [0, 1]);
        var _inputs = 
        {
            up: global.key_up[1],
            down: global.key_down[1],
            left: global.key_left[1],
            right: global.key_right[1],
            jump: global.key_jump[1],
            spin: global.key_spin[1],
            dash: global.key_dash[1],
            special: global.key_special[1],
            crouch: global.key_crouch[1],
            start: global.key_start[1]
        };
        var _arr = struct_get_names(_inputs);
        
        for (var j = 0; j < array_length(_arr); j++)
        {
            var _key = _arr[j];
            var _value = variable_struct_get(_inputs, _key);
            input_binding_set(_key, input_binding_key(_value), 1, undefined, "keyboard_and_mouse");
        }
        
        input_binding_set("crouch", input_binding_key(global.key_down[1]), 1, undefined, "keyboard_and_mouse");
    }
}
