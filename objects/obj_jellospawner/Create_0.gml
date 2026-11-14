onoff = noone;
onoff_ind = 0;
hspd = 4;
timer[0] = timer_length;

timer_func[0] = function()
{
    var _inst = instance_create_layer(x, y, layer, obj_jello);
    _inst.hspd = hspd;
    _inst.die_outside_room = sign(hspd);
    _inst.sub_movement = false;
    
    if (onoff != noone)
    {
        _inst.onoff = onoff[onoff_ind];
        onoff_ind++;
        
        if (onoff_ind > (array_length(onoff) - 1))
            onoff_ind = 0;
    }
    
    timer[0] = timer_length;
};

alarm[0] = 1;
create_multiple = false;
