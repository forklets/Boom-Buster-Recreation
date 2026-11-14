timer_logic(0);
timer_logic(1);

if (global.tutorial_trigger == string_index)
    in = true;
else
    in = false;

if (instance_exists(obj_round_clear))
    in = false;

image_alpha = approach(image_alpha, in, 0.07);
