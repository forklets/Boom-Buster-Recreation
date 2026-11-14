if (!edit_mode)
    exit;

mx = window_mouse_get_x();
my = window_mouse_get_y();
get_cams(0);
var _inst, _fat;

if (element_selected != noone)
{
    _inst = global.elements[element_selected];
    
    if (struct_exists(_inst, "fat"))
        _fat = _inst.fat;
    else
        _fat = false;
    
    if (struct_exists(_inst, "chute"))
        var _chute = _inst.chute;
    else
        var _chute = false;
}

if (mx < 1408 && !mouse_gui)
{
    var _x = device_mouse_x_to_gui(0) + camx;
    var _y = device_mouse_y_to_gui(0) + camy;
    mx_grid = round(_x / grid_x) * grid_x;
    my_grid = round(_y / grid_y) * grid_y;
    
    if (element_selected != noone)
    {
        var _str = asset_obj[_inst.row][_inst.ind];
        
        if (keyboard_check_pressed(ord("X")) && _inst.row == 3)
        {
            _inst.facing = !_inst.facing;
            
            if (_inst.facing == 0)
                _inst.facing = -1;
        }
        
        if (!struct_exists(_inst, "mypath"))
        {
            if (_inst.row == 1)
                draw_sprite_ext(spr_barrel, 0, mx_grid, my_grid, 1, 1, 0, c_white, 0.0525);
            
            draw_sprite_ext(name_to_spr(_str, _inst.ind, _fat), 0, mx_grid, my_grid, 1, 1, 0, c_white, 0.35);
            
            if (mouse_check_button_pressed(mb_left) && !mouse_gui)
            {
                _inst.x = mx_grid;
                _inst.y = my_grid;
            }
        }
    }
}

for (var i = 0; i < array_length(global.elements); i++)
{
    if (!view_all && element_selected != i)
        continue;
    
    _inst = global.elements[i];
    var _str = asset_obj[_inst.row][_inst.ind];
    
    if (struct_exists(_inst, "wings") && _inst.wings)
        var _wings = true;
    else
        var _wings = false;
    
    if (struct_exists(_inst, "fat") && _inst.fat)
        _fat = true;
    else
        _fat = false;
    
    if (struct_exists(_inst, "chute") && _inst.chute)
        var _chute = true;
    else
        var _chute = false;
    
    var _alpha;
    
    if (element_selected == i)
        _alpha = 1;
    else
        _alpha = 0.5;
    
    var _facing;
    
    if (_inst.row == 3)
        _facing = _inst.facing;
    else
        _facing = 1;
    
    if (struct_exists(_inst, "mypath"))
    {
        var _path = asset_get_index(_inst.mypath);
        _inst.x = path_get_x(_path, _inst.path_pos);
        _inst.y = path_get_y(_path, _inst.path_pos);
        draw_path(_path, 0, 0, true);
    }
    
    if (_inst.row == 1)
        draw_sprite_ext(spr_barrel, 0, _inst.x, _inst.y, _facing, 1, 0, c_white, _alpha * 0.3);
    
    if (_str == "obj_gem" && struct_exists(_inst, "col"))
        pal_swap(pal_gem, 0, _inst.col);
    
    if (_str == "obj_key" && struct_exists(_inst, "col"))
        pal_swap(pal_key, 0, _inst.col);
    
    if (_str == "obj_bom_swap" && struct_exists(_inst, "col"))
        pal_swap(pal_swapbom, 0, _inst.col + 1);
    
    if (_str == "obj_bom_anxious" && struct_exists(_inst, "col"))
        pal_swap(pal_bom_anxious, 0, _inst.col + 1);
    
    draw_sprite_ext(name_to_spr(_str, _inst.ind, _fat), 0, _inst.x, _inst.y, _facing, 1, 0, c_white, _alpha);
    
    if ((_str == "obj_gem" || _str == "obj_bom_swap" || _str == "obj_key" || _str == "obj_bom_anxious") && struct_exists(_inst, "col"))
        shader_reset();
    
    if (struct_exists(_inst, "wings") && _inst.wings)
        draw_sprite(spr_wing, 0, _inst.x - 48, _inst.y - 50);
}

if (mouse_check_button_pressed(mb_middle) || keyboard_check_pressed(vk_control))
{
    element_selected = noone;
    selected_row = -4;
    selected_index = -4;
}
