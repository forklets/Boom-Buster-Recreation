function scr_set_highscore()
{
    var _room = room;
    
    if (room == rm_round_7_3)
        _room = rm_round_7_1;
    else if (room == rm_round_b7_3)
        _room = rm_round_b7_1;
    else if (room == rm_round_14_3)
        _room = rm_round_14_1;
    else if (room == rm_round_b14_3)
        _room = rm_round_b14_1;
    else if (room == rm_round_21_3)
        _room = rm_round_21_1;
    else if (room == rm_round_b21_3)
        _room = rm_round_b21_1;
    else if (room == rm_final)
        _room = rm_final_scroll;
    else if (room == rm_final_b)
        _room = rm_final_scroll_b;
    
    var _dollars = global.dollars - global.dollars_start;
    var _highscore = 0;
    
    if (struct_exists(global.save.round_highscores, room_get_name(_room)))
        _highscore = variable_struct_get(global.save.round_highscores, room_get_name(_room));
    
    if (_dollars > _highscore)
        struct_set(global.save.round_highscores, room_get_name(_room), _dollars);
}
