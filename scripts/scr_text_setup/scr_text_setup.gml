function scr_text_setup(arg0)
{
    line = [];
    var _lines = 0;
    
    for (var i = 0; i < string_length(arg0); i++)
    {
        var _chr = string_char_at(arg0, i + 1);
        
        if (_chr == "/")
            _lines++;
    }
    
    for (var i = 0; i < _lines; i++)
    {
        line[i] = 
        {
            characters: [],
            width: 0,
            glyphs: []
        };
    }
    
    var _w = 0;
    var _line = 0;
    
    for (var i = 0; i < string_length(arg0); i++)
    {
        var _chr = string_char_at(arg0, i + 1);
        array_push(line[_line].characters, _chr);
        
        if (_chr == "<")
        {
            array_push(line[_line].glyphs, string_char_at(arg0, i + 2));
            i++;
        }
        else
        {
            if (_chr != "/")
                _w += string_width(_chr);
            
            if (_chr == "/")
            {
                line[_line].width = _w;
                _w = 0;
                _line++;
            }
        }
    }
    
    return line;
}
