for (var i = 0; i < ds_list_size(carried.list_carry); i++)
{
    if (ds_list_find_value(carried.list_carry, i) == id)
    {
        my_index = i;
        break;
    }
}

var _grounded = false;

with (carried)
{
    if (on_ground())
        _grounded = true;
}

if (carried.vspd > 0)
{
    var _to = -carried.vspd * 2.5;
    _to *= ((my_index + 1) * 0.4);
    fall_yoff = easy_smooth(fall_yoff, _to, 2);
    last_fall_vspd = carried.vspd;
}
else if (!_grounded)
{
    fall_yoff = easy_smooth(fall_yoff, 0, 2);
    last_fall_vspd = 0;
}

if (carried.vspd != 0)
{
    bounce = false;
    bounce_count = 0;
    bounce_vspd = 0;
    bounce_yoff = 0;
    fall_smooth = false;
}

if (_grounded && fall_yoff != 0 && !bounce)
{
    if (last_fall_vspd > 12)
    {
        bounce_yoff = fall_yoff;
        bounce_vspd = last_fall_vspd;
        bounce = true;
        fall_yoff = 0;
    }
    else
    {
        fall_smooth = true;
    }
}

if (fall_smooth)
    fall_yoff = easy_smooth(fall_yoff, 0, 3);

if (bounce)
{
    if (!_grounded)
        bounce_count = 1;
    
    bounce_vspd += grav;
    bounce_yoff += bounce_vspd;
    
    if (bounce_yoff >= 0)
    {
        var _count = bounce_count;
        var _count_needed = 0;
        
        if (last_fall_vspd >= 30)
            _count_needed = 2;
        else if (last_fall_vspd >= 15)
            _count_needed = 1;
        else
            _count_needed = 0;
        
        if (_count < _count_needed)
        {
            var _mult = 1;
            
            if (_count == 1)
                _mult = 0.5;
            
            if (_count_needed == 2)
                bounce_vspd = -10;
            else
                bounce_vspd = -6.5;
            
            bounce_vspd *= _mult;
            bounce_yoff = bounce_vspd - 1;
        }
        else
        {
            bounce_yoff = 0;
            bounce_vspd = 0;
            bounce = false;
        }
        
        bounce_count++;
    }
}
