function draw_bg(arg0, arg1, arg2, arg3, arg4 = 0, arg5 = 16777215, arg6 = false)
{
    var _spr = arg0;
    var _w = sprite_get_width(_spr);

    if (arg6)
        _max = 3;
    else
        _max = 1;

    for (var i = 0; i < _max; i++)
        draw_sprite_ext(_spr, arg1, arg2 + (_w * i), arg3, 1, 1, 0, c_white, 1);

    if (arg4 <= 0)
        exit;
}
