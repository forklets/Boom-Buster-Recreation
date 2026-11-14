if (deac)
    exit;

var _yAxis = input_check_pressed_all("down") - input_check_pressed_all("up");
selected += _yAxis;
var _max = array_length(options) - 1;
selected = clamp(selected, 0, _max);

if (input_check_pressed_all("jump"))
{
    options_event[selected]();
    input_verb_consume_all("jump");
}

if (keyboard_check_pressed(vk_space) && global.debug)
    frame = 0;
