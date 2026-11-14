if (!exit_freeze())
    timer--;

if (timer == 0)
{
    if (item != noone)
    {
        var _y = global.room_top - 64;
        var _chute_item;
        
        if (chute)
        {
            _chute_item = item;
            item = obj_parachute;
            _y -= 72;
        }
        
        var _item = instance_create_layer(x, _y, "Instances_Over", item);
        _item.col = ind;
        _item.wings = wings;
        _item.fat = fat;
        _item.toggle_pause = toggle_pause;
        
        if (chute)
            _item.item = _chute_item;
        
        if (landYobj == noone)
            _item.landY = y;
        else
            _item.landYobj = landYobj;
        
        if (mypath != noone)
        {
            _item.mypath = mypath;
            _item.path_pos = path_pos;
            _item.x = path_get_x(mypath, path_pos);
            _item.landY = path_get_y(mypath, path_pos);
        }
        
        if (item == obj_barrel)
            _item.myInst = barrel_item;
    }
    
    instance_destroy();
}
