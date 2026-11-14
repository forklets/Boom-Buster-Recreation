for (var i = 0; i < 2; i++)
{
    var _test = 5;
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
    ini_open("options.ini");
    var _arr = struct_get_names(_inputs);
    
    for (var j = 0; j < array_length(_arr); j++)
    {
        var _key = _arr[j];
        var _value = variable_struct_get(_inputs, _key);
        input_binding_set(_key, input_binding_key(_value), i, undefined, "keyboard_and_mouse");
        ini_write_real($"{i} KEYBOARD", _key, _value);
    }
    
    input_binding_set("crouch", input_binding_key(global.key_down[i]), i, undefined, "keyboard_and_mouse");
    ini_close();
}
