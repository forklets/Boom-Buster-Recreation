function draw_bg_ext(arg0, arg1, arg2, arg3, arg4 = 1, arg5 = 1, arg6 = 0, arg7 = 16777215, arg8 = 1, arg9 = 0, arg10 = 16777215, arg11 = false)
{
    var _spr = arg0;
    var _w = sprite_get_width(_spr);
    var _max;
    
    if (arg11)
        _max = 3;
    else
        _max = 1;
    
    for (var i = 0; i < _max; i++)
        draw_sprite_ext(_spr, arg1, arg2 + (_w * i), arg3, arg4, arg5, arg6, arg7, arg8);
    
    shader_set(sha_flash);
    
    for (var i = 0; i < _max; i++)
        draw_sprite_ext(_spr, arg1, arg2 + (_w * i), arg3, arg4, arg5, arg6, arg10, arg9);
    
    shader_reset();
}
