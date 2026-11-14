anim_logic();

if (out)
{
    if (timer[0] == -1)
        timer[0] = 2;
    
    timer_logic(0);
    
    if (scale <= 0.5)
        instance_destroy();
}
