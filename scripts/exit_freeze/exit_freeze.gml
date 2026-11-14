function exit_freeze()
{
    if (object_get_parent(object_index) == par_enemy || object_get_parent(object_index) == par_player)
    {
        if (bonus_freeze)
            return true;
    }
    
    if ((array_contains(global.stages_final, room) || array_contains(global.stages_final_scroll, room)) && object_get_parent(object_index) == par_enemy && object_index != obj_hamster)
    {
        get_cams(0);
        
        if (array_contains(global.stages_final, room) && y <= camy)
            return true;
        
        if (array_contains(global.stages_final_scroll, room) && (x - 32) > (camx + camw))
            return true;
    }
    
    return ds_list_find_index(global.list_ignorefreeze, id) == -1 && (global.freeze || (instance_exists(obj_editor) && obj_editor.edit_mode) || global.goodnight || instance_exists(obj_paused));
}
