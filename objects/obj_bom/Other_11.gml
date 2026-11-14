if (collected)
    exit;

collected = true;
physics_simple = true;
event_inherited();

if (!throwable)
    obj_controller.boms_left--;

timer[0] = -1;
anim_play(asset_get_index($"spr_bom_{col_to_str(col)}"));
