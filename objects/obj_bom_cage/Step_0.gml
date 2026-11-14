anim_logic();

if (!instance_exists(bom_inside))
    bom_inside = noone;

if (bom_inside == noone && instance_exists(cage_anim))
{
    with (cage_anim)
        instance_destroy();
}

if (bom_inside != noone && instance_exists(bom_inside))
{
    if (bom_inside.edge || bom_inside.omg)
        flash -= (delta_time / 1000000);
    else
        flash = 0;
    
    if (flash < 0)
        flash = flash_time;
    
    if (bom_inside.omg && flash_time != flash_time_fast)
    {
        flash_time = flash_time_fast;
        flash = flash_time;
    }
    
    if (instance_exists(cage_anim))
        cage_anim.flash = flash / flash_time;
}
