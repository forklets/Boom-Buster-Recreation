last_sides = [];
timer[0] = -1;

timer_func[0] = function()
{
    timer[0] = irandom_range(480, 750);
    var _side = choose(-1, 1);
    
    if (array_length(last_sides) >= 2)
    {
        var _check = _side;
        var _all_same = true;
        
        for (var i = 0; i < 2; i++)
        {
            if (last_sides[i] != _check)
            {
                _all_same = false;
                break;
            }
        }
        
        if (_all_same)
            _side = -_side;
    }
    
    var _x;
    
    if (_side == -1)
        _x = -128;
    else
        _x = 1536;
    
    var _inst = instance_create_layer(_x, 0, layer, obj_bg_mall_npc);
    _inst.dir = -_side;
    _inst.image_index = irandom_range(0, sprite_get_number(spr_bg_mall_guy) - 1);
    var _on_screen = [];
    
    for (var i = 0; i < instance_number(obj_bg_mall_npc); i++)
    {
        var _look = instance_find(obj_bg_mall_npc, i);
        
        if (_look.id == _inst.id)
            continue;
        
        array_push(_on_screen, _look.image_index);
    }
    
    while (array_contains(_on_screen, _inst.image_index))
    {
        _inst.image_index++;
        
        if (_inst.image_index > (sprite_get_number(spr_bg_mall_guy) - 1))
            _inst.image_index = 0;
    }
    
    array_push(last_sides, _side);
    
    if (array_length(last_sides) > 10)
        array_shift(last_sides);
};

timer_func[0]();
