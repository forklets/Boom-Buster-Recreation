function scr_check_all_foods()
{
    var _foodsA = [rm_round_1, rm_round_2, rm_round_3, rm_round_4, rm_round_5, rm_round_6, rm_round_8, rm_round_9, rm_round_10, rm_mall_extra1, rm_round_11, rm_round_12, rm_round_13, rm_round_15, rm_round_16, rm_round_17, rm_factory_extra1, rm_round_18, rm_round_19, rm_round_20, rm_outskirts_1, rm_outskirts_2, rm_outskirts_3];
    var _foodsB = [rm_round_b1, rm_round_b2, rm_round_b3, rm_round_b4, rm_round_b5, rm_round_b6, rm_round_b8, rm_round_b9, rm_round_b10, rm_mall_extrab1, rm_round_b11, rm_round_b12, rm_round_b13, rm_round_b15, rm_round_b16, rm_round_b17, rm_factory_extrab1, rm_round_b18, rm_round_b19, rm_round_b20, rm_outskirts_b1, rm_outskirts_b2, rm_outskirts_b3];
    var _all_A = true;
    var _all_B = true;

    for (var i = 0; i < array_length(_foodsA); i++)
    {
        if (!array_contains(global.save.round_foods, room_get_name(_foodsA[i])))
        {
            _all_A = false;
            break;
        }
    }

    for (var i = 0; i < array_length(_foodsB); i++)
    {
        if (!array_contains(global.save.round_foods, room_get_name(_foodsB[i])))
        {
            _all_B = false;
            break;
        }
    }

    if (_all_A)
        scr_get_achievement("FOOD");

    if (_all_B)
        scr_get_achievement("FOOD_B");
}
