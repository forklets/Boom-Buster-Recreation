function scr_tv_create_bridget()
{
    char_reload = function()
    {
        if (global.player_character[0] == 0)
            tv_char = 1;
        else
            tv_char = 0;
        
        if (global.players > 1)
            tv_char = choose(0, 1);
        
        var _dig = [spr_tv_buster_dig, spr_tv_bridget_dig];
        var _toss = [spr_tv_buster_toss, spr_tv_bridget_toss];
        var _brb = [spr_tv_brb_buster, spr_tv_brb_bridget];
        tv_char_dig = _dig[tv_char];
        tv_char_toss = _toss[tv_char];
        tv_char_brb = _brb[tv_char];
    };
    
    char_reload();
    
    if (bridget_state == bridget_state_dig)
        bridget_sprite = tv_char_dig;
    
    bridget_sub = 0;
    bridget_timer = 0;
    bridget_pause = false;
    bridget_item = 0;
    bridget_itemspd = 1;
    bridget_set_finishtimer = false;
    
    bridget_toss = function()
    {
        bridget_state = bridget_state_toss;
        bridget_sub = 0;
        bridget_sprite = tv_char_toss;
        var _path, _path_pos;
        
        if (struct_exists(bridget_element, "mypath"))
        {
            _path = asset_get_index(bridget_element.mypath);
            _path_pos = bridget_element.path_pos;
        }
        else
        {
            _path = noone;
        }
        
        var _wings = struct_exists(bridget_element, "wings") && bridget_element.wings;
        var _fat = struct_exists(bridget_element, "fat") && bridget_element.fat;
        var _toggle_pause = struct_exists(bridget_element, "toggle_pause") && bridget_element.toggle_pause;
        var _chute = struct_exists(bridget_element, "chute") && bridget_element.chute;
        var _drop = instance_create_layer(bridget_element.x, bridget_element.y, layer, obj_droptimer);
        _drop.ind = bridget_element.ind;
        
        if (_path != noone)
        {
            _drop.mypath = _path;
            _drop.path_pos = _path_pos;
        }
        
        if (bridget_element.row == 0)
        {
            _drop.item = obj_bom;
        }
        else
        {
            _drop.item = obj_barrel;
            var _barrel_item = asset_get_index(asset_obj[bridget_element.row][bridget_element.ind]);
            _drop.barrel_item = _barrel_item;
        }
        
        _drop.wings = _wings;
        _drop.toggle_pause = _toggle_pause;
        
        if (_fat)
            _drop.item = obj_bom_fat;
        
        if (_chute)
            _drop.chute = true;
        
        if (struct_exists(bridget_element, "land_id"))
            _drop.landYobj = land_id_obj[bridget_element.land_id];
    };
    
    timer[timer_bridget] = -1;
    
    timer_func[timer_bridget] = function()
    {
        var _state = bridget_state;
        
        if (_state == bridget_state_react)
        {
            bridget_state = bridget_state_wind;
            bridget_sub = 0;
            bridget_sprite = bridget_get("wind");
            
            if (bridget_itemspd == 1)
                timer[timer_bridget] = 48;
            else if (bridget_itemspd == 0)
                timer[timer_bridget] = 78;
        }
        else if (_state == bridget_state_wind)
        {
            bridget_toss();
        }
    };
    
    timer[timer_bridget_finish] = -1;
    
    timer_func[timer_bridget_finish] = function()
    {
        bridget_state = bridget_state_done;
        bridget_sub = 0;
        bridget_sprite = spr_tv_bridget_done;
        bridget_done = true;
        
        if (tv_char == 0)
            bridget_sprite = spr_tv_buster_done;
    };
    
    bridget_done = false;
    
    bridget_animend = function()
    {
        var _state = bridget_state;
        var _check = bridget_sprite;
        
        if (_check == spr_tv_buster_done)
        {
            bridget_sub = sprite_get_number(bridget_sprite) - 1 - 2;
            exit;
        }
        
        if (_state == bridget_state_pull)
        {
            if (bridget_itemspd == 2)
            {
                bridget_toss();
            }
            else
            {
                bridget_state = bridget_state_react;
                bridget_sub = 0;
                bridget_sprite = bridget_get("react");
                
                if (bridget_itemspd == 1)
                    timer[timer_bridget] = 30;
                else if (bridget_itemspd == 0)
                    timer[timer_bridget] = 60;
            }
        }
        else if (_state == bridget_state_wind)
        {
            bridget_sub = sprite_get_number(bridget_sprite) - 3;
        }
        else if (_state == bridget_state_toss)
        {
            bridget_state = bridget_state_dig;
            bridget_sub = 0;
            bridget_sprite = tv_char_dig;
        }
        else if (_state == bridget_state_done)
        {
            var _spr = bridget_sprite;
            
            if (_spr == spr_tv_bridget_done)
            {
                bridget_sub = 0;
                bridget_sprite = spr_tv_bridget_done_end;
            }
            else if (_spr == spr_tv_bridget_done_end)
            {
                bridget_sub = 8;
            }
        }
    };
    
    event_bridget_unpause = function()
    {
        bridget_pause = false;
        bridget_timer++;
    };
}
