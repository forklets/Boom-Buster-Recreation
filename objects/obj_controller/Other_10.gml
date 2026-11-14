if (instance_exists(obj_player_death))
    exit;

if (win || wizard_win)
    exit;

if (room == rm_round_7_3 || room == rm_round_14_3 || room == rm_round_21_3 || room == rm_round_b7_3 || room == rm_round_b14_3 || room == rm_round_b21_3 || room == rm_outskirts_3 || room == rm_outskirts_b3)
    wizard_win = true;
else
    win = true;

timer[timer_bridget] = -1;
global.invincible = false;
alarm[1] = 3;

if (global.world == 0)
{
    with (obj_player_ghost)
        out = true;
}

if (stage_event == "wizard")
{
    instance_create_layer(0, 0, "GUI", obj_wizardevent_win);
    
    with (par_player)
        deac_controls = true;
    
    exit;
}

instance_create_layer(0, 0, layer, obj_round_clear);
