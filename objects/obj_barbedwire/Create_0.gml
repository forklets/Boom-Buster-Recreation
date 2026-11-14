active_wait = 180;
timer[0] = active_wait;

timer_func[0] = function()
{
    active = true;
    anim_play(spr_barbedwire_0_active);
    hurt_box = instance_create_layer(x, y - 1, layer, par_hurt);
    hurt_box.visible = false;
    hurt_box.image_xscale = image_xscale;
    timer[1] = 60;
};

timer[1] = -1;

timer_func[1] = function()
{
    active = false;
    timer[0] = active_wait;
    anim_play(spr_barbedwire_0);
    
    if (instance_exists(hurt_box))
        instance_destroy(hurt_box);
};

anim_init();
