event_inherited();

if (global.playground || infinite || array_contains(global.stages_final, room))
{
    life = 599940;
    life_flicker = life - 150;
    timer[0] = -1;
    timer[1] = -1;
    flicker = false;
    image_alpha = 1;
}

if (exit_freeze())
    exit;

if (!collected)
{
    time_angle += 8;
    var _xoff = (xstart / 64) * 90;
    yoff = dsin(_xoff + time_angle) * 3;
    y = ystart + yoff;
}

timer_logic(timer_sparkle);
