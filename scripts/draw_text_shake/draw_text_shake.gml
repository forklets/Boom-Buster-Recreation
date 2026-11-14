function draw_text_shake(arg0, arg1, arg2, arg3 = 0.5, arg4 = 1, arg5 = 1)
{
    var _widths = {};
    _widths[$ "\""] = 16;
    _widths[$ "."] = 8;
    var _str = arg2;
    var _x = arg0;
    var _y = arg1;
    var ALIGN = draw_get_halign();
    var __str = string_delete(_str, string_length(_str) - 1, 1);
    
    if (ALIGN == 1)
        _x -= (((string_width(__str) - 1) * arg4) / 2);
    
    for (var i = 0; i < string_length(_str); i++)
    {
        var _chance = random_range(0, 1);
        var _shake = _chance <= arg3;
        var _xshake = _shake * random_range(-1, 1);
        var _yshake = _shake * random_range(-1, 1);
        _x += _xshake;
        _y += _yshake;
        var _chr = string_char_at(_str, i + 1);
        var _offset = string_width(_chr) * arg4 * 0.5;
        var _weirds = ["-", "'", "."];
        
        if (array_contains(_weirds, _chr))
            _x -= _offset;
        
        draw_text_transformed(_x, _y, _chr, arg4, arg5, 0);
        
        if (struct_exists(_widths, _chr))
            _x += (struct_get(_widths, _chr) * arg4);
        else
            _x += (string_width(_chr) * arg4);
        
        if (array_contains(_weirds, _chr))
            _x += _offset;
        
        _x -= _xshake;
        _y -= _yshake;
    }
}
