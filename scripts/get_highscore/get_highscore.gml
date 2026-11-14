function get_highscore()
{
    var _look;
    
    if (global.bside)
        _look = game_save_id + "highscoresB.json";
    else
        _look = game_save_id + "highscores.json";
    
    var _data;
    
    if (file_exists(_look))
        _data = load_json(_look);
    else
        _data = {};
    
    var _table;
    
    if (struct_exists(_data, "highscores"))
        _table = _data.highscores;
    else
        _table = [["TGG", 2400], ["WIZ", 2150], ["BRI", 2000], ["BUS", 1900], ["GOB", 1800], ["HIS", 1600], ["PIN", 1500], ["ROD", 1400], ["BAL", 1200], ["LIP", 1000]];
    
    var _sort = function(arg0, arg1)
    {
        return sign(arg1[1] - arg0[1]);
    };
    
    array_sort(_table, _sort);
    return _table;
}
