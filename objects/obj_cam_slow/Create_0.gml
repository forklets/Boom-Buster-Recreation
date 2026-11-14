done = false;
slowed = false;
timer[0] = -1;

timer_func[0] = function()
{
    slowed = true;
    
    with (obj_controller)
        cam_go = true;
    
    with (obj_lava)
        rise = false;
};

timer[1] = 25;

timer_func[1] = function()
{
    ready = true;
};

ready = false;
visible = false;
y += 128;
