string_index = 0;
alarm[0] = 1;
ready = false;
str = "No text set./";
image_alpha = 0;
timer[0] = -1;

timer_func[0] = function()
{
    global.tutorial_trigger = 1;
    timer[1] = 150;
};

timer[1] = -1;

timer_func[1] = function()
{
    var _inst = instance_create_layer(307, 806, "Instances_Behind", obj_cutout_wizard);
    
    for (var i = 0; i < 6; i++)
    {
        var _x = _inst.x;
        var _y = _inst.y;
        _x += irandom_range(-60, 60);
        _y += irandom_range(-60, 60);
        var _fx = instance_create_layer(_x, _y, "Particles_Over", obj_fx);
        _fx.anim_sprite = spr_fx_smoke;
    }
};
