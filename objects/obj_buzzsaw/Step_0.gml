if (exit_freeze() && path_lock_timer == -1)
    exit;

if (path_lock_timer > -1)
    path_lock_timer--;

if (!bonus_freeze)
{
    path_follow();
    
    repeat (abs(hspd))
        x += sign(hspd);
    
    repeat (abs(vspd))
        y += sign(vspd);
}

angle += (-6 * (1 / image_xscale));
