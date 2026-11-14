timer_logic(1);

if (!ready)
    exit;

timer_logic(0);

if (slowed)
{
    image_blend = c_lime;
    exit;
}

get_cams(0);

if (camy <= bbox_top)
{
    with (obj_lava)
        rise = true;
    
    var _exists = false;
    
    with (obj_tower_wall)
    {
        if (y >= other.camy)
            _exists = true;
    }
    
    if (!_exists && !done)
    {
        done = true;
        
        if (!obj_controller.cam_go)
            timer[0] = 30;
        else
            timer_func[0]();
        
        exit;
    }
    
    image_blend = c_red;
    
    with (obj_controller)
        cam_go = false;
}
else
{
    image_blend = c_white;
}
