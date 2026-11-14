deac = false;
rounds[0] = [[rm_round_1, rm_round_b1], [rm_round_2, rm_round_b2], [rm_round_3, rm_round_b3], [rm_round_4, rm_round_b4], [rm_round_5, rm_round_b5], [rm_round_6, rm_round_b6], [rm_round_7_1, rm_round_b7_1]];
rounds[1] = [[rm_round_8, rm_round_b8], [rm_round_9, rm_round_b9], [rm_round_10, rm_round_b10], [rm_mall_extra1, rm_mall_extrab1], [rm_round_11, rm_round_b11], [rm_round_12, rm_round_b12], [rm_round_13, rm_round_b13], [rm_round_14_1, rm_round_b14_1]];
rounds[2] = [[rm_round_15, rm_round_b15], [rm_round_16, rm_round_b16], [rm_round_17, rm_round_b17], [rm_round_18, rm_round_b18], [rm_factory_extra1, rm_factory_extrab1], [rm_round_19, rm_round_b19], [rm_round_20, rm_round_b20], [rm_round_21_1, rm_round_b21_1]];
rounds[3] = [[rm_outskirts_1, rm_outskirts_b1], [rm_outskirts_2, rm_outskirts_b2], [rm_outskirts_3, rm_outskirts_b3], [rm_final_scroll, rm_final_scroll_b]];
rounds[4] = [[rm_bonus_1, rm_bonus_b1], [rm_bonus_2, rm_bonus_b2], [rm_bonus_3, rm_bonus_b3]];
menu = 0;
deac = false;

for (var i = 0; i < array_length(rounds); i++)
    selected[i] = 0;

menu = global.round_select_menu;
selected[menu] = global.round_select_selected;
bar_shake = 0;
round_dollars = 0;

if (global.debug)
{
    global.save.stages_beat = [];
    
    for (var i = 0; i < array_length(global.stages); i++)
    {
        array_push(global.save.stages_beat, room_get_name(global.stages[i][0]));
        array_push(global.save.stages_beat, room_get_name(global.stages[i][1]));
    }
}

voice_play = noone;
