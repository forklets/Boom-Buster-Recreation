function __input_config_verbs()
{
    return 
    {
        keyboard_and_mouse: 
        {
            up: input_binding_key(38),
            down: input_binding_key(40),
            left: input_binding_key(37),
            right: input_binding_key(39),
            jump: input_binding_key(90),
            spin: input_binding_key(88),
            dash: input_binding_key(67),
            special: input_binding_key(32),
            crouch: input_binding_key(16),
            start: input_binding_key(27)
        },
        gamepad: 
        {
            up: [input_binding_gamepad_axis(32786, true), input_binding_gamepad_button(32781)],
            down: [input_binding_gamepad_axis(32786, false), input_binding_gamepad_button(32782)],
            left: [input_binding_gamepad_axis(32785, true), input_binding_gamepad_button(32783)],
            right: [input_binding_gamepad_axis(32785, false), input_binding_gamepad_button(32784)],
            jump: input_binding_gamepad_button(32769),
            spin: input_binding_gamepad_button(32771),
            dash: [input_binding_gamepad_button(32770), input_binding_gamepad_button(32774), input_binding_gamepad_button(32776)],
            special: input_binding_gamepad_button(32772),
            crouch: [input_binding_gamepad_button(32773), input_binding_gamepad_button(32775)],
            start: input_binding_gamepad_button(32778),
            back: input_binding_gamepad_button(32770)
        },
        touch: 
        {
            up: input_binding_virtual_button(),
            down: input_binding_virtual_button(),
            left: input_binding_virtual_button(),
            right: input_binding_virtual_button(),
            accept: input_binding_virtual_button(),
            cancel: input_binding_virtual_button(),
            action: input_binding_virtual_button(),
            special: input_binding_virtual_button(),
            pause: input_binding_virtual_button()
        }
    };
}
