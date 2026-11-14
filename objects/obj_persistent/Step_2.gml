if (global.debug && keyboard_check_pressed(ord("5")) && keyboard_check(vk_shift))
{
    var _str = get_string("", "");
    scr_get_achievement(_str);
}

var _deadzone;

if (global.deadzone == 0)
    _deadzone = 0.4;
else if (global.deadzone == 1)
    _deadzone = 0.6;
else if (global.deadzone == 2)
    _deadzone = 0.85;

var _device = -1;

for (var i = 0; i < gamepad_get_device_count(); i++)
{
    if (gamepad_is_connected(i))
    {
        _device = i;
        gamepad_set_axis_deadzone(_device, _deadzone);
    }
}
