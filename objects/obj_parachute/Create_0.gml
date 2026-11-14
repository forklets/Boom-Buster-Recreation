if (global.bside)
    vspd = 2.75;
else
    vspd = 2.25;

event_explode = function()
{
    instance_destroy();
};

event_touch = function(arg0)
{
    var _destroy = true;
    
    switch (item)
    {
        case obj_bom:
            var _ignore = false;
            
            if (ds_list_size(arg0.list_carry) > 0)
            {
                if (ds_list_find_value(arg0.list_carry, 0).col != col)
                    _ignore = true;
            }
            
            if (!_ignore)
            {
                var _inst = instance_create_layer(arg0.x, arg0.y - 24, layer, obj_bom);
                _inst.col = col;
                
                with (arg0)
                    event_user(3);
            }
            else
            {
                _destroy = false;
            }
            
            break;
    }
    
    if (_destroy)
        instance_destroy();
};

anim_init();
ready = false;
alarm[0] = 1;
wave_offset = random_range(0, 1.5707963267948966);
