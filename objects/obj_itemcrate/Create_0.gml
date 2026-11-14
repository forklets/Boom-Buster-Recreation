event_inherited();
grav = 0;
item = obj_dynalife;
jumpable = false;
timer[2] = 5;

timer_func[2] = function()
{
    var _w = sprite_width;
    var _h = sprite_height;
    var _x = x + irandom_range(-_w / 2, _w / 2);
    var _y = y + irandom_range(-_h / 2, _h / 2);
    var _fx = instance_create_layer(_x, _y, "Particles_Over", obj_fx);
    
    with (_fx)
        anim_play(spr_fx_sparkle_tiny_yellow);
    
    timer[2] = 5;
};

timer[3] = 2;

timer_func[3] = function()
{
    var _fx = instance_create_layer(x, y + wings_sin, "Particles_Behind", obj_fx);
    
    with (_fx)
    {
        anim_play(spr_itemcrate);
        destroy = 1;
        image_alpha_to = 0;
        image_alpha_spd = 0.025;
        image_alpha = 0.5;
        image_angle = other.image_angle;
        xscale_add = 0.025;
        yscale_add = 0.025;
        bm = 1;
    }
    
    timer[3] = 30;
};
