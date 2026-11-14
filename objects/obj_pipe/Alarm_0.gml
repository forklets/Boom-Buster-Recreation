myBox = noone;
var _box = instance_place(x, y + 10, obj_pipebox);

if (_box)
{
    myBox = _box.id;
    _box.col = col;
    
    if ((col % 2) == 0)
        _box.anim_sprite = spr_pipebox_orange;
    else
        _box.anim_sprite = spr_pipebox_cyan;
}

if (instance_exists(myBox))
{
    boxX = myBox.x;
    boxY = myBox.y;
}
