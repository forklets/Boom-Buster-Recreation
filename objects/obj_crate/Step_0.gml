get_cams();

if (exit_freeze())
    exit;

if (!event_ready())
    exit;

if (place_meeting(x, y, obj_player))
    event_break();

anim_logic();
timer_logic(1);

if (!wings && room != rm_final && room != rm_final_b)
    physics_apply();
else
    vspd = 0;

if (vspd > 12)
    vspd = 12;

y += vspd;

if (timer[0] <= 90)
{
    if (timer[1] == -1)
        timer[1] = 3;
    
    if (!flicker)
        image_alpha = 0.4;
    else
        image_alpha = 0.85;
}

if (wings)
{
    var _xoff = (xstart / 64) * 90;
    wing_ind += 0.35;
    wings_sin = sin((_xoff / pi) + time) * 3;
    time += 0.2;
}
else
{
    wings_sin = 0;
}

if (place_meeting(x, y, obj_explosion_radius))
    event_break();
