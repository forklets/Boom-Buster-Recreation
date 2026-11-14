event_inherited();

if (exit_freeze())
    exit;

anim_logic();
x += hspd;

if (x > (room_width + 128) || x < (-room_width - 128))
    instance_destroy();
