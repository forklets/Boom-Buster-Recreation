event_inherited();

if (exit_freeze())
    exit;

if (place_meeting(x, y, obj_lava))
    event_explode();

timer_logic(timer_sparkle);
