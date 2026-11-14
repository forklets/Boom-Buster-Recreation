event_inherited();
wings_sin = sin(time) * 6;
time += 0.135;
angle = sin(time * 1.5) * 1.75;
timer_logic(2);
timer_logic(3);

timer_func[3] = function()
{
    var _fx = instance_create_layer(x, y, "Particles_Behind", obj_fx);
    
    with (_fx)
    {
        anim_play(spr_itemcrate);
        destroy = 1;
        image_alpha_to = 0;
        image_alpha_spd = 0.025;
        image_alpha = 0.5;
        xscale_add = 0.025;
        yscale_add = 0.025;
        bm = 1;
    }
    
    timer[3] = 30;
};
