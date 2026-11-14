if (array_contains(global.stages_final, room))
{
    get_cams();
    instance_deactivate_object(obj_crate);
    instance_deactivate_object(par_enemy);
    instance_deactivate_object(obj_coin);
    instance_activate_region(camx - 128, camy - 256, camx + 1408 + 128, camy + 1080 + 256, true);
}

var _gameW;

if (global.playground)
    _gameW = 1920;
else
    _gameW = 1408;

if (target_swap == 0)
    target = obj_player;
else
    target = obj_player;

target = obj_player;
var _xAdd = 0;
var _yAdd = 0;

for (var i = 0; i < instance_number(par_player); i++)
{
    var _inst = instance_find(par_player, i);
    _xAdd += _inst.x;
    _yAdd += _inst.y;
}

if (instance_number(par_player) > 1)
{
    _xAdd /= 2;
    _yAdd /= 2;
}

if (keyboard_check_pressed(vk_f8) && global.debug)
    target_swap = !target_swap;

if (target_swap != 0)
{
    var _zoom = 0.6;
    _camw = _gameW;
    var _w = _camw * _zoom;
    var _h = 1080 * _zoom;
    camera_set_view_size(view_camera[0], _w, _h);
    
    if (instance_exists(target))
    {
        _x = target.x - (_w / 2);
        _x = clamp(_x, 64, room_width - _w - 64);
        var _targetY = target.y;
        _targetY = 1023;
        _y = _targetY - (52 * (1 - _zoom)) - (_h / 2);
        _y = clamp(_y, global.room_top, room_height - _h - 64);
        camera_set_view_pos(view_camera[0], _x, _y - view_yoff);
    }
    
    exit;
}

if (cam_stretch)
    camera_set_view_size(view_camera[0], room_width, room_height);
else
    camera_set_view_size(view_camera[0], _gameW * zoom, 1080 * zoom);

if (array_contains(global.stages_final, room))
{
    x = 64;
    
    if (instance_exists(target) && !final_ended)
    {
        if (cam_final)
        {
            y = target.y + cam_final_yoff;
            y = clamp(y, obj_cam_final_maxY.y + 64, room_height - 1080 - 64);
            cam_final_yoff = easy_smooth(cam_final_yoff, -668, 10);
        }
        else if (cam_go)
        {
            cam_spd = approach(cam_spd, 1.7, 0.011333333333333332);
        }
        else
        {
            cam_spd = approach(cam_spd, 0, 0.01888888888888889);
        }
        
        if (!exit_freeze())
            y -= cam_spd;
    }
    
    get_cams(0);
    var _camy = camy;
    
    if (jello_bounced)
    {
        with (par_player)
        {
            if (y < (_camy + 540))
                obj_controller.y = easy_smooth(obj_controller.y, y - 540, 5);
            
            if (grounded)
                obj_controller.jello_bounced = false;
        }
    }
    else
    {
        with (par_player)
        {
            if (state != state_cannon && !cannon_shot)
            {
            }
        }
    }
}
else if (global.auto_scroller)
{
    var _time;
    
    if (obj_editor.edit_mode)
        _time = obj_editor.camera_timestamp;
    else
        _time = bridget_timer;
    
    var _dist_per_second = 144;
    var _dist = (_time / 60) * _dist_per_second;
    x = 64 + _dist;
    x = clamp(x, 64, room_width - 1408 - 64);
}
else if (global.stage_type == 0)
{
    if (cam_free_x)
    {
        x = _xAdd - (_gameW / 2);
        x = clamp(x, 64, room_width - _gameW);
    }
    else if (locked_x != -4)
    {
        x = locked_x;
    }
    else if (instance_exists(target))
    {
        var _nocam = false;
        
        with (target)
        {
            if (place_meeting(x, y, obj_nocam))
            {
                var _inst = instance_place(x, y, obj_nocam);
                
                if (_inst.vertical_only)
                    _nocam = true;
            }
        }
        
        if (!_nocam)
        {
            var relativePosition = clamp((_xAdd - barrierL) / (barrierR - barrierL), 0, 1);
            
            if (relative_position == -4)
                relative_position = relativePosition;
            
            relative_position = lerp(relative_position, relativePosition, relative_pos_ease);
            relative_pos_ease = approach(relative_pos_ease, 1, 0.025);
            x = lerp(64, room_width - (64 * zoom) - (_gameW * zoom), relative_position);
        }
    }
    
    if (cam_free_y)
    {
        y = _yAdd - 540;
        y = clamp(y, global.room_top, room_height - 1080 - 64);
    }
    else if (locked_y != -4)
    {
        y = locked_y;
    }
    else if (instance_exists(target) && !place_meeting(target.x, target.y, obj_nocam))
    {
        var _nocam = false;
        
        with (target)
        {
            if (place_meeting(x, y, obj_nocam))
            {
                var _inst = instance_place(x, y, obj_nocam);
                
                if (_inst.horizontal_only)
                    _nocam = true;
            }
        }
        
        if (!_nocam)
        {
            var relativePosition = clamp((_yAdd - barrierU) / (barrierD - barrierU), 0, 1);
            y = lerp(global.room_top + cam_yoff, room_height - (64 * zoom) - (1080 * zoom), relativePosition);
        }
    }
}
else if (global.stage_type == 1)
{
    if (instance_exists(target))
        x = (target.x - 704) + 200;
    
    y = 0;
}

var _x = !cam_stretch * (x + (global.screenshake[0] * zoom) + cam_xoff);
var _y = !cam_stretch * (y + (global.screenshake[1] * zoom) + cam_yoff + 8);
camera_set_view_pos(view_camera[0], _x, _y);

if (global.stage_type == 1)
{
    instance_deactivate_object(obj_solid);
    instance_deactivate_object(obj_semisolid);
    instance_deactivate_object(par_enemy);
    instance_deactivate_object(par_carry);
    get_cams();
    instance_activate_region(camx - 64, camy, 1472, 1080, true);
    
    if (instance_exists(obj_player))
    {
        for (var i = 0; i < ds_list_size(obj_player.list_carry); i++)
            instance_activate_object(ds_list_find_value(obj_player.list_carry, i));
    }
}

if (obj_editor.edit_mode)
{
    xAxis = keyboard_check(ord("D")) - keyboard_check(ord("A"));
    yAxis = keyboard_check(ord("S")) - keyboard_check(ord("W"));
    cam_xoff += ((xAxis * 6) + (xAxis * (6 * !keyboard_check(vk_shift))));
    cam_yoff += ((yAxis * 6) + (yAxis * (6 * !keyboard_check(vk_shift))));
    
    if (keyboard_check_pressed(vk_tab))
    {
        cam_xoff = 0;
        cam_yoff = 0;
    }
}
