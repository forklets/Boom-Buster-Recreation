function solid_meeting(arg0, arg1, arg2)
{
    if (place_meeting(arg0, arg1, arg2))
    {
        var _list = instance_place_array(arg0, arg1, arg2);
        
        for (var i = 0; i < array_length(_list); i++)
        {
            if (!value_in_list(list_ignore, _list[i]))
            {
                _list = [];
                return true;
            }
        }
        
        _list = [];
    }
    
    return false;
}
