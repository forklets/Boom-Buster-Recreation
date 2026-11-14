if (exit_freeze())
    exit;

if (instance_exists(obj_player_death))
    exit;

timer_logic(0);
y += vspd;

if (y > (room_height + 192))
    instance_destroy();
