event_inherited();
infinite = false;
time_angle = 0;
timer_sparkle = array_length(timer);
timer[timer_sparkle] = 5;

timer_func[timer_sparkle] = function()
{
    timer[timer_sparkle] = irandom_range(10, 15);
    
    if (place_meeting(x, y, obj_tower_wall))
        exit;
    
    var _x = x;
    var _y = y;
    _x += irandom_range(-30, 30);
    _y += irandom_range(-30, 30);
    var _layer = "Particles_Over";
    var _fx = instance_create_layer(_x, _y, _layer, obj_fx);
    
    with (_fx)
        anim_play(spr_fx_sparkle_tiny_yellow);
};
