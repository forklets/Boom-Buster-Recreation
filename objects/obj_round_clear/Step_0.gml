hue += 2;

if (in_tutorial)
    y = easy_smooth(y, 96, 12);
else
    y = easy_smooth(y, 50, 24);

if (global.debug && keyboard_check_pressed(vk_space))
{
    hue = 0;
    y = ystart;
}

timer_logic(0);
timer_logic(1);
timer_logic(2);
timer_logic(3);
timer_logic(4);

if (checkmark)
    percent_checkmark = approach(percent_checkmark, 1, 0.041666666666666664);

if (slide_msg)
    slide_x = easy_smooth(slide_x, 0, 12);
