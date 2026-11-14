anim_logic();

if (eyes_sprite != noone)
{
    eyes_index += (sprite_get_speed(eyes_sprite) / 60);
    
    if (eyes_index >= sprite_get_number(eyes_sprite))
    {
        eyes_index -= eyes_index;
        event_eyes_animend();
    }
}

timer_logic(0);
timer_logic(1);
timer_logic(2);

if (bounce_state == -1)
{
    scale_percent = approach(scale_percent, 1, 0.02);
    xscale = use_curve(acurv_basics, scale_percent, "bounce", 1.3, 1);
    yscale = use_curve(acurv_basics, scale_percent, "bounce", 0.7, 1);
}
else if (bounce_state == 0)
{
    scale_percent = approach(scale_percent, 1, 0.02);
    xscale = use_curve(acurv_basics, scale_percent, "bounce", 0.7, 1);
    yscale = use_curve(acurv_basics, scale_percent, "bounce", 1.3, 1);
}

if (yoff < 0)
    vspd += grav;

if ((yoff + vspd) >= 0)
{
    if (vspd > 0)
        event_yoff_land();
    
    yoff = 0;
    vspd = 0;
}

yoff += vspd;
