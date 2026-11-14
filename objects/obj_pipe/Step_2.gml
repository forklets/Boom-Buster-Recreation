var _xbefore = x;

if (global.auto_scroller)
{
    wings = true;
    get_cams(0);
    x = (camx + xstart) - 96;
    y = ystart;
}

var _above = instance_place_array(x, y - 1, par_physics);

for (var i = 0; i < array_length(_above); i++)
{
    var _instX = _above[i].x;
    var _instY = _above[i].y;
    
    if (!(_above[i].y <= y))
        continue;
    
    _above[i].x += x - _xbefore;
    
    with (_above[i])
    {
        if (place_meeting(x, y, obj_solid))
            x = _instX;
    }
    
    _above[i].pipe_ysin = wings_yoff;
}
