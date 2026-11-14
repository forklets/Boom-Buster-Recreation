function input_check_all(arg0)
{
    var _bool = false;
    
    for (var i = 0; i < 2; i++)
        _bool = _bool || input_check(arg0, i);
    
    return _bool;
}

function input_check_pressed_all(arg0)
{
    var _bool = false;
    
    for (var i = 0; i < 2; i++)
        _bool = _bool || input_check_pressed(arg0, i);
    
    return _bool;
}
