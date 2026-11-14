function __input_steam_apply_trigger_effect(arg0, arg1, arg2, arg3)
{
    static _global = __input_global();
    static _steam_trigger_params = {};
    static _command_array = [{}, {}];
    
    if (0 || _global.__on_wine || !is_numeric(arg0))
        return false;
    
    if (!is_struct(arg1))
        return false;
    
    if (!is_struct(arg1[$ "__params"]))
        return false;
    
    var _left = 0;
    var _right = 1;
    var _key_data = "command_data";
    variable_struct_set(_command_array[_left], _key_data, {});
    variable_struct_set(_command_array[_right], _key_data, {});
    variable_struct_set(variable_struct_get(_command_array[arg2], _key_data), string(arg1.__mode_name) + "_param", arg1.__params);
    var _key_mode = "mode";
    variable_struct_set(_command_array[_left], _key_mode, 0);
    variable_struct_set(_command_array[_right], _key_mode, 0);
    variable_struct_set(_command_array[arg2], _key_mode, variable_struct_get(_global.__steam_trigger_mode, arg1.__mode));
    
    if (arg1.__params[$ "amplitude"] != undefined)
        variable_struct_set(arg1.__params, "amplitude", arg1.__params[$ "amplitude"] * arg3);
    
    if (arg1.__params[$ "strength"] != undefined)
        variable_struct_set(arg1.__params, "strength", arg1.__params[$ "strength"] * arg3);
    
    _steam_trigger_params.command = _command_array;
    var _key_trigger_mask = "trigger_mask";
    
    if (arg2 == _left)
        variable_struct_set(_steam_trigger_params, _key_trigger_mask, 1);
    
    if (arg2 == _right)
        variable_struct_set(_steam_trigger_params, _key_trigger_mask, 2);
    
    return steam_input_set_dualsense_trigger_effect(arg0, _steam_trigger_params);
}
