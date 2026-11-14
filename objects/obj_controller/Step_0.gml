if (array_contains(global.stages_final_scroll, room))
{
    get_cams();
    part_system_position(ps_rain, camx, camy);
}

var _turn_y = 4800;
_turn_y = 3216;

if (array_contains(global.stages_final, room) && instance_exists(obj_player) && obj_player.y <= _turn_y && !wizard_turned)
{
    wizard_sprite = spr_tv_wizard_huh;
    wizard_sub = 0;
    channel = 2;
    wizard_turned = true;
}

if (array_contains(global.stages_final, room) && instance_exists(obj_player) && obj_player.y <= 18696 && !wizard_waitshit)
{
    audio_sound_gain(voice_wizard_wait, 3.85, 0);
    audio_play_sound(voice_wizard_wait, 0, false);
    wizard_waitshit = true;
}

timer_logic(timer_clear);

if (global.debug && keyboard_check_pressed(ord("0")) && !obj_editor.edit_mode)
{
    with (par_player)
        event_user(0);
}

if (global.debug && keyboard_check_pressed(ord("1")) && !obj_editor.edit_mode)
{
    with (par_player)
        instance_create_layer(x, y, layer, obj_dynalife);
}

flash_overlay = approach(flash_overlay, 0, 0.08);
hp_spr = asset_get_index($"spr_ui_hp{global.hp}");

if (global.debug)
{
    if (keyboard_check_pressed(ord("T")))
        follow_target = !follow_target;
    
    if (keyboard_check_pressed(vk_f2))
        cam_stretch = !cam_stretch;
}

if (fps_caption_timer)
    fps_caption_timer--;

if (fps_caption_timer == 0)
    fps_caption_timer = 20;

if (global.freeze)
{
    global.freeze--;
    
    if (global.freeze == 0)
        global.freeze_func();
}

if (!(exit_freeze() && !global.hurt))
{
    combo_meter_lerp = lerp(combo_meter_lerp, global.combo_meter, 0.22);
    global.combo_meter = clamp(global.combo_meter, 0, global.combo_meter_max);
    pattern_x -= 0.25;
    pattern_y += 0.16666666666666666;
    
    if (pattern_x == sprite_get_width(spr_charpattern) || pattern_x == -sprite_get_width(spr_charpattern))
        pattern_x -= pattern_x;
    
    if (pattern_y == sprite_get_height(spr_charpattern))
        pattern_y -= pattern_y;
}

if (!exit_freeze())
{
    var _yoff;
    
    if (!display_highscore)
        _yoff = -130;
    else
        _yoff = 0;
    
    if (global.hurt)
        hp_ind += (sprite_get_speed(hp_spr) / 60);
    
    if (hp_ind >= sprite_get_number(hp_spr))
        hp_ind -= hp_ind;
    
    if (timer[timer_dollars_flash])
        part_particles_create(global.part_gui, global.app_xoff + 1408 + 162 + irandom_range(0, 292), 834 + _yoff + irandom_range(0, 63), global.particles.sparkleGreen, 1);
    
    if (boms_leftUI != boms_left)
    {
        boms_leftUI = boms_left;
        anim_bombfuse = 24;
        boms_leftOffset = 12;
        spark_posTo = 1 - (boms_left / boms_total);
        
        if (spark_posTo == 1)
            spark_pos = 1;
        
        if (spark_pos == 1)
            part_particles_create(global.part_gui, global.app_xoff + 1707, 363, global.particles.smoke, 1);
        
        if (boms_leftUI == 0 && !instance_exists(obj_player_death))
            event_user(0);
    }
    
    if (keyboard_check_pressed(ord("F")) && global.debug)
        event_user(0);
    
    spark_pos = lerp(spark_pos, spark_posTo, 0.5);
    
    if (anim_bombfuse)
    {
        bombfuse_ind += (sprite_get_speed(spr_ui_bombSpark) / 60);
        
        if (bombfuse_ind >= sprite_get_number(spr_ui_bombSpark))
            bombfuse_ind -= bombfuse_ind;
        
        anim_bombfuse--;
    }
    
    if (boms_leftOffset)
        boms_leftOffset--;
}

if (!exit_freeze() && !instance_exists(obj_stagestart_boss) && !instance_exists(obj_player_death) && final_ready)
{
    var _contains = false;
    
    if (array_contains(global.stages_final, room))
        _contains = true;
    else
        _contains = array_contains(list_timestamps, bridget_timer);
    
    if (array_contains(global.stages_final, room) && global.debug)
    {
        with (par_player)
        {
            if (y <= 22656)
                _contains = false;
        }
    }
    
    if (_contains)
    {
        for (var i = 0; i < array_length(global.elements); i++)
        {
            if (array_contains(global.stages_final, room))
            {
                if (bridget_timer < global.elements[i].timestamp)
                    continue;
                
                if (array_contains(elements_completed_final, global.elements[i]))
                    continue;
                
                array_push(elements_completed_final, global.elements[i]);
            }
            else if (global.elements[i].timestamp != bridget_timer)
            {
                continue;
            }
            
            var _element = global.elements[i];
            
            switch (_element.row)
            {
                case 0:
                    bridget_element = _element;
                    bridget_state = bridget_state_pull;
                    
                    if (_element.row == 0)
                        bridget_item = _element.ind;
                    
                    bridget_sprite = bridget_get("pull");
                    bridget_sub = 0;
                    
                    if (variable_struct_exists(_element, "spd"))
                        bridget_itemspd = _element.spd;
                    else
                        bridget_itemspd = 1;
                    
                    break;
                
                case 2:
                case 7:
                case 1:
                    var _x, _y, _path, _path_pos;
                    
                    if (struct_exists(_element, "mypath"))
                    {
                        _path = asset_get_index(_element.mypath);
                        _path_pos = _element.path_pos;
                        _x = path_get_x(_path, _path_pos);
                        _y = path_get_y(_path, _path_pos);
                    }
                    else
                    {
                        _path = noone;
                        _path_pos = 0;
                        _x = _element.x;
                        _y = _element.y;
                    }
                    
                    var _wings;
                    
                    if (struct_exists(_element, "wings"))
                        _wings = _element.wings;
                    else
                        _wings = false;
                    
                    var _obj = asset_get_index(asset_obj[_element.row][_element.ind]);
                    var _barrel_item = noone;
                    var _drops = [obj_gem, obj_key];
                    var _drop_item;
                    
                    if (array_contains(_drops, _obj) || _element.row == 7 || _element.row == 1)
                    {
                        _drop_item = _obj;
                        _obj = obj_droptimer;
                        
                        if (_element.row == 1)
                        {
                            _barrel_item = _drop_item;
                            _drop_item = obj_barrel;
                        }
                    }
                    
                    var _spawn = instance_create_layer(_x, _y, "Instances", _obj);
                    _spawn.mypath = _path;
                    _spawn.path_pos = _path_pos;
                    _spawn.wings = _wings;
                    
                    if (_obj == obj_droptimer)
                    {
                        _spawn.item = _drop_item;
                        
                        if (struct_exists(_element, "col"))
                            _spawn.ind = _element.col;
                        else
                            _spawn.ind = 0;
                        
                        if (_barrel_item != noone)
                            _spawn.barrel_item = _barrel_item;
                    }
                    
                    if (_obj != obj_food && _obj != obj_crate && _obj != obj_droptimer)
                        part_particles_create(global.part_over, _x, _y, global.particles.smoke, 1);
                    
                    break;
                
                case 3:
                    var _x, _y, _path, _path_pos;
                    
                    if (struct_exists(_element, "mypath"))
                    {
                        _path = asset_get_index(_element.mypath);
                        _path_pos = _element.path_pos;
                        _x = path_get_x(_path, _path_pos);
                        _y = path_get_y(_path, _path_pos);
                    }
                    else
                    {
                        _path = noone;
                        _path_pos = 0;
                        _x = _element.x;
                        _y = _element.y;
                    }
                    
                    var _spawn = instance_create_layer(_x, _y, "Instances", obj_grodiespawn);
                    _spawn.enemy = asset_obj[3][_element.ind];
                    _spawn.facing = _element.facing;
                    _spawn.mypath = _path;
                    _spawn.path_pos = _path_pos;
                    break;
                
                case 4:
                    if (_element.ind == 0)
                    {
                        channel_change(_element.channel);
                    }
                    else if (_element.ind == 1)
                    {
                        if (struct_exists(_element, "spr_change"))
                        {
                            bridget_sprite = asset_get_index(_element.spr_change);
                            bridget_sub = 0;
                        }
                    }
                    
                    if (_element.ind == 2)
                    {
                        wizard_sprite = asset_get_index(_element.spr_change);
                        wizard_sub = 0;
                    }
                    
                    break;
                
                case 5:
                    if (asset_obj[5][_element.ind] == "obj_lightning")
                    {
                        instance_create_layer(_element.x, _element.y, "Instances", obj_lightning);
                    }
                    else if (asset_obj[5][_element.ind] == "obj_lightsout")
                    {
                        var _spawn = instance_create_depth(_element.x, _element.y, layer_get_depth(layer_get_id("GUI")) - 1, obj_lightsout);
                        _spawn.timer[0] = _element.length * 60;
                    }
                    else if (asset_obj[5][_element.ind] == "obj_fireball")
                    {
                        var _spawn = instance_create_layer(_element.x - (384 * sign(_element.hspd)), _element.y, "Instances", obj_fireball);
                        _spawn.hspd = _element.hspd;
                        audio_stop_play(snd_flame, 0, 0);
                    }
                    else if (asset_obj[5][_element.ind] == "obj_knife_indicator")
                    {
                        var _spawn = instance_create_layer(_element.x, _element.y, "Instances_Over", obj_knife_indicator);
                    }
                    
                    break;
                
                case 6:
                    if (asset_obj[6][_element.ind] == "play sound")
                        audio_play_sound(asset_get_index(_element.snd), 0, 0);
                    else if (asset_obj[6][_element.ind] == "pause")
                        bridget_pause = true;
                    
                    break;
            }
        }
    }
    
    if (bridget_timer > last_timestamp && bridget_state == bridget_state_dig && !bridget_set_finishtimer)
    {
        if (stage_event == "bossfight")
        {
        }
        else
        {
            timer[timer_bridget_finish] = 30;
            bridget_set_finishtimer = true;
        }
    }
    
    if (!bridget_pause && !win)
        bridget_timer++;
    
    if (array_contains(global.stages_final, room))
    {
        get_cams(0);
        bridget_timer = floor((-(camy - 28552) / 64) * 60);
    }
}

if (!exit_freeze())
{
    timer_logic(timer_dollars_flash);
    timer_logic(timer_bridget);
    timer_logic(timer_bridget_finish);
    
    if (!instance_exists(obj_fx_combo_bar))
        timer_logic(timer_win);
    
    timer_logic(timer_channel);
    timer_logic(timer_hey);
    timer_logic(timer_meter_icon_flash);
    timer_logic(timer_cam_go);
}

if (!exit_freeze() && !instance_exists(obj_paused) && !instance_exists(obj_stagestart) && !win)
{
    if (input_check_pressed_all("start"))
        instance_create_depth(0, 0, layer_get_depth(layer_get_id("Transition")), obj_paused);
}
