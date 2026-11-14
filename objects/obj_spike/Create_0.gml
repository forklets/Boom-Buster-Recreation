if (image_xscale > 1)
{
    for (var i = 0; i < image_xscale; i++)
        instance_create_layer(x + (64 * i), y, layer, obj_spike);
}

image_xscale = 1;
anim_init();
anim_speed = 0;
facing = 1;
impaled = false;

event_impale = function(arg0, arg1, arg2, arg3)
{
    var _impale = instance_create_depth(x, y, layer_get_depth(layer) - 10, obj_spike_impale);
    _impale.palette = arg0;
    _impale.char = arg1;
    _impale.facing = arg2;
    _impale.anim_index = arg3;
    _impale.my_spike = id;
};

for (var i = 0; i < array_length(global.hurt_remember_players); i++)
{
    var _inst = global.hurt_remember_players[i];
    
    if (_inst.x == xstart && _inst.y == ystart && _inst.object_index == _inst.object_index)
    {
        event_impale(_inst.palette, _inst.char, _inst.facing, _inst.anim_index);
        break;
    }
}

if (anim_index > (sprite_get_number(anim_sprite) - 1))
    anim_index = sprite_get_number(anim_sprite) - 1;
