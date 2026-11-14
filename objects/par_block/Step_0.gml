if (exit_freeze())
    exit;

anim_logic();
xscale = sin(scale_percent * pi) * 0.5;
yscale = sin(scale_percent * pi) * 0.5;

if (hit)
{
    scale_percent = approach(scale_percent, 1, 0.068);
    
    if (scale_percent == 1)
    {
        scale_percent = 0;
        hit = false;
    }
}
