if (create_multiple)
{
    for (var i = 0; i < 5; i++)
    {
        var _inst = instance_create_layer(x + (i * (hspd * timer_length)), y, layer, obj_jello);
        _inst.hspd = hspd;
        _inst.die_outside_room = 1;
        
        if (onoff != noone)
        {
            _inst.onoff = onoff[onoff_ind];
            onoff_ind++;
            
            if (onoff_ind > (array_length(onoff) - 1))
                onoff_ind = 0;
        }
    }
}
