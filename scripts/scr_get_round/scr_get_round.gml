function scr_get_round(arg0)
{
    if (array_contains(global.stages_tutorial, arg0))
    {
        for (var i = 0; i < array_length(global.stages_tutorial); i++)
        {
            if (room == global.stages_tutorial[i])
                return i;
        }
    }
    
    var _ignore = [[rm_bonus_1, rm_bonus_b1], [rm_bonus_2, rm_bonus_b2], [rm_bonus_3, rm_bonus_b3], [rm_round_7_2, rm_round_b7_2], [rm_round_7_3, rm_round_b7_3], [rm_round_14_2, rm_round_b14_2], [rm_round_14_3, rm_round_b14_3], [rm_round_21_2, rm_round_b21_2], [rm_round_21_3, rm_round_b21_3]];
    var _ignore_total = [];
    
    for (var i = 0; i < array_length(_ignore); i++)
    {
        array_push(_ignore_total, _ignore[i][0]);
        array_push(_ignore_total, _ignore[i][1]);
    }
    
    var _rounds = [];
    
    for (var i = 0; i < array_length(global.stages); i++)
    {
        var _room = global.stages[i][global.bside];
        
        if (array_contains(_ignore_total, _room))
            continue;
        
        array_push(_rounds, _room);
    }
    
    for (var i = 0; i < array_length(_rounds); i++)
    {
        if (arg0 == _rounds[i])
        {
            return i;
            break;
        }
    }
    
    return -1;
}
