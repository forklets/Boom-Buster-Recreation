function scr_get_bonus(arg0)
{
    var _rounds = [[rm_bonus_1, rm_bonus_b1], [rm_bonus_2, rm_bonus_b2], [rm_bonus_3, rm_bonus_b3]];
    
    for (var i = 0; i < array_length(_rounds); i++)
    {
        if (arg0 == _rounds[i][0] || arg0 == _rounds[i][1])
        {
            return i;
            break;
        }
    }
    
    return -1;
}
