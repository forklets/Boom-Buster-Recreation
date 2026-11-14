if (!instance_exists(obj_killbom))
{
    var _inst = instance_create_layer(0, room_height - 128, "GUI", obj_killbom);
    _inst.image_xscale = room_width / 64;
    
    if (global.auto_scroller)
        _inst.y = room_height - 48;
}

if (!instance_exists(obj_pit))
{
    var _inst = instance_create_layer(0, room_height + 192, "GUI", obj_pit);
    _inst.image_xscale = room_width / 64;
    
    if (global.auto_scroller)
        _inst.y = room_height + 192;
}
