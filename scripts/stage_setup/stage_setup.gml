function stage_setup()
{
    global.elements = [];
    list_timestamps = [];
    
    if (array_contains(global.stages_tutorial, room))
    {
        bgm = bgm_grotto;
    }
    else if (room == rm_bonus_1 || room == rm_bonus_2 || room == rm_bonus_3 || room == rm_bonus_b1 || room == rm_bonus_b2 || room == rm_bonus_b3)
    {
        if (global.bside)
            bgm = noone;
        else
            bgm = noone;
    }
    else if (global.round <= 6)
    {
        if (global.bside)
            bgm = bgm_city_b;
        else
            bgm = bgm_city;
    }
    else if (global.round <= 14)
    {
        if (global.bside)
            bgm = bgm_mall_b;
        else
            bgm = bgm_mall;
    }
    else if (global.bside)
    {
        bgm = bgm_factory_b;
    }
    else
    {
        bgm = bgm_factory;
    }
    
    bgm_fakeout = bgm;
    global.map_path_data = ds_map_create();
    var _undefined = false;
    var _method = 1;
    
    if (_method == 0)
    {
        var _rm = room_get_name(room);
        var _scr = asset_get_index($"stageload_{_rm}");
        
        if (script_exists(_scr))
            script_execute(_scr);
        else
            show_debug_message($"'stageload_{_rm}' doesn't exist");
    }
    else if (_method == 1 && !_undefined)
    {
        var _file;
        
        if (keyboard_check(vk_shift) && global.debug)
            _file = get_open_filename("*.json", "");
        else
            _file = $"stages/{directory_get(global.bside)}/{room_get_name(room)}.json";
        
        var _data = undefined;

        if (_file != "" && file_exists(_file))
            _data = load_json(_file);

        if (!is_struct(_data))
        {
            show_debug_message($"stage_setup: no stage data for '{room_get_name(room)}' (file: '{_file}'), loading empty stage");
            _data = {};
        }

        if (global.round_select)
        {
            if (struct_exists(global.save.round_highscores, room_get_name(room)))
                global.top_dollars = variable_struct_get(global.save.round_highscores, room_get_name(room));
            else
                global.top_dollars = 0;
        }
        else
        {
            global.top_dollars = get_highscore()[0][1];
        }
        
        if (struct_exists(_data, "bossfight"))
            bossfight = _data.bossfight;
        
        if (array_contains(global.wizard_events_total, room))
            stage_event = "wizard";
        
        if (array_contains(global.stages_outskirts, room))
            bgm = bgm_outskirts;
        else if (array_contains(global.stages_final, room) || array_contains(global.stages_final_scroll, room))
            bgm = bgm_finale;
        else if (stage_event == "wizard")
            bgm = bgm_boss;
        
        if (struct_exists(_data, "name"))
            global.act_name = _data.name;
        else
            global.act_name = "NO LEVEL NAME";
        
        paths = [];
        
        if (struct_exists(_data, "paths"))
        {
            paths = _data.paths;
            
            for (var i = 0; i < array_length(paths); i++)
            {
                var _name = paths[i].name;
                var _thing = {};
                
                if (struct_exists(paths[i], "pause"))
                    _thing.pause = paths[i].pause;
                
                if (struct_exists(paths[i], "ease"))
                    _thing.ease = paths[i].ease;
                
                if (struct_exists(paths[i], "spd"))
                    _thing.spd = paths[i].spd;
                
                ds_map_add(global.map_path_data, _name, _thing);
            }
        }
        
        var _elements_array = struct_exists(_data, "elements") ? _data.elements : [];
        
        for (var i = 0; i < array_length(_elements_array); i++)
            array_push(global.elements, _elements_array[i]);
        
        _data = undefined;
    }
    
    boms_total = 0;
    
    for (var i = 0; i < array_length(global.elements); i++)
    {
        var _element = global.elements[i];
        
        if (_element == "none")
        {
            global.elements = [];
            break;
        }
        
        array_push(list_timestamps, _element.timestamp);
        
        if (_element.row == 0 || _element.row == 7)
            boms_total++;
    }
    
    array_sort(list_timestamps, false);
    
    if (array_length(list_timestamps) > 0)
        last_timestamp = list_timestamps[0];
    else
        last_timestamp = undefined;
    
    if (boms_total == 0)
    {
        bridget_state = bridget_state_brb;
        bridget_sprite = tv_char_brb;
    }
    
    if (room == rm_tutorial_5)
        boms_total = 1;
    else if (room == rm_tutorial_6)
        boms_total = 4;
}
