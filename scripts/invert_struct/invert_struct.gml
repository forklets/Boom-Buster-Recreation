function invert_struct(arg0)
{
    var _inverted_struct = {};
    var _keys = struct_get_names(arg0);
    
    for (var i = 0; i < array_length(_keys); i++)
    {
        var _key = _keys[i];
        var _value = variable_struct_get(arg0, _key);
        variable_struct_set(_inverted_struct, _value, _key);
    }
    
    return _inverted_struct;
}
