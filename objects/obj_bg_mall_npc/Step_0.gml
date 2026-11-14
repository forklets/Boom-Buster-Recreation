if (exit_freeze())
    exit;

x += (hspd * dir);

if ((hspd * dir) > 0)
    facing = -1;

if ((hspd * dir) < 0)
    facing = 1;

if (image_index == 1)
    y = 10;
else
    y = (sin(current_time / 95) * 3) + 6 + 8;

if (x > 1708 || x < -300)
    instance_destroy();
