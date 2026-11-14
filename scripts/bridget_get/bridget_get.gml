function bridget_get(arg0)
{
    var _char;
    
    if (tv_char == 0)
        _char = "buster";
    else
        _char = "bridget";
    
    var _str = $"spr_tv_{_char}_{arg0}_{col_to_str(bridget_item)}";
    
    if (asset_get_index(_str) < 0)
        _str = $"spr_tv_bridget_{arg0}_{col_to_str(bridget_item)}";
    
    return asset_get_index(_str);
}
