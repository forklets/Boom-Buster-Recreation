if (exit_freeze())
    exit;

physics_apply();
anim_logic();
timer_logic(0);
timer_logic(1);
