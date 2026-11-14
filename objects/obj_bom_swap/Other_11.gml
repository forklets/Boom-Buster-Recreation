event_inherited();
var _pipes = [];

with (obj_pipe)
{
    array_push(_pipes, 
    {
        inst: id,
        col: col,
        x: x,
        y: y,
        box: myBox,
        boxX: myBox.x,
        boxY: myBox.y
    });
}

array_sort(_pipes, function(arg0, arg1)
{
    return arg0.col - arg1.col;
});
var _len = array_length(_pipes);
var _x1 = pipe_entered.x;

for (var i = 0; i < _len; i++)
{
    var _next = ((i - 1) + _len) % _len;
    _pipes[_next].inst.x = _pipes[i].x;
    _pipes[_next].inst.y = _pipes[i].y;
    _pipes[_next].box.x = _pipes[i].boxX;
    _pipes[_next].box.y = _pipes[i].boxY;
}

var _x2 = pipe_entered.x;
var _dist = _x2 - _x1;

with (par_carry)
{
    if (tossed && !collected)
        x += _dist;
}

with (obj_pipe)
{
    if (instance_exists(myBox))
    {
        boxX = myBox.x;
        boxY = myBox.y;
    }
}

with (obj_pipe)
{
    for (var i = 0; i < array_length(boms); i++)
        boms[i].x += _dist;
}

with (obj_fx_combo)
    x += _dist;
