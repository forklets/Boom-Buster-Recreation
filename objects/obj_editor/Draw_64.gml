mouse_gui = false;

if (!edit_mode)
    exit;

mx = window_mouse_get_x();
my = window_mouse_get_y();

if (display_ui)
{
    draw_columns(spr_editor_boms, 0);
    draw_columns(spr_editor_barrel, 1);
    draw_columns(spr_editor_items, 2);
    draw_columns(spr_editor_grodies, 3);
    draw_columns(spr_editor_tv, 4);
    draw_columns(spr_editor_wizard, 5);
    draw_columns(spr_editor_misc, 6);
    draw_columns(spr_editor_boms_special, 7);
}

var _orange = 0;
var _cyan = 0;
var _purple = 0;

for (var i = 0; i < array_length(global.elements); i++)
{
    var _element = global.elements[i];
    
    if (_element.row == 0)
    {
        if (_element.ind == 0)
            _orange++;
        else if (_element.ind == 1)
            _cyan++;
        else if (_element.ind == 2)
            _purple++;
    }
}

var _x = 10;
draw_rectangle_color((_x + global.app_xoff) - 4, 10, _x + global.app_xoff + 26, 27, c_black, c_black, c_black, c_black, false);
_x = 82;
draw_rectangle_color((_x + global.app_xoff) - 4, 10, _x + global.app_xoff + 26, 27, c_black, c_black, c_black, c_black, false);
_x = 154;
draw_rectangle_color((_x + global.app_xoff) - 4, 10, _x + global.app_xoff + 26, 27, c_black, c_black, c_black, c_black, false);
draw_set_font(fnt_debug);
draw_text(10 + global.app_xoff, 10, _orange);
draw_text(10 + global.app_xoff + 72, 10, _cyan);
draw_text(10 + global.app_xoff + 144, 10, _purple);
draw_rectangle_color(global.app_xoff + 1408, 0, global.app_xoff + 1408 + 1408, 1080, c_black, c_black, c_black, c_black, false);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);

for (var i = 0; i < 240; i++)
{
    draw_set_font(fnt_debug);
    
    if (!(i % 5) && i != 0)
        draw_text(global.app_xoff + 1846 + 44, scroll_y + (60 * i), i);
    
    draw_set_alpha(0.3);
    draw_line(global.app_xoff + 1408, (60 * i) + scroll_y, global.app_xoff + 1846, scroll_y + (60 * i));
    draw_set_alpha(1);
    draw_sprite_gui(spr_editor_bracket, 0, 1846, scroll_y + (60 * i));
}

draw_set_valign(fa_top);
draw_set_halign(fa_left);

if (mx >= 1408)
{
    mx_grid = round(mx / 20) * 20;
    
    if (keyboard_check(vk_shift))
        my_grid = round((my - scroll_y) / 30) * 30;
    else
        my_grid = round((my - scroll_y) / 60) * 60;
    
    mx_grid = clamp(mx_grid, 1460, 1800);
    
    if (selected_row != -4)
    {
        if (selected_row == 4)
            var _str = "wizard_attack";
        else
            var _str = asset_obj[selected_row][selected_index];
        
        draw_sprite_gui_ext(row_spr[selected_row], selected_index, mx_grid, my_grid + scroll_y, undefined, undefined, undefined, undefined, 0.4);
        
        if (mouse_check_button_pressed(mb_left))
        {
            var _element = 
            {
                x: 0,
                y: 0,
                cx: mx_grid,
                timestamp: my_grid,
                row: selected_row,
                ind: selected_index
            };
            
            if (selected_row == 0)
            {
                _element.spd = 1;
            }
            else if (selected_row == 3)
            {
                _element.facing = 1;
            }
            else if (selected_row == 4)
            {
                if (selected_index == 0)
                {
                    _element.wait = 30;
                    _element.channel = 0;
                }
            }
            else if (selected_row == 5)
            {
                if (selected_index == 1)
                    _element.length = 2;
                else if (selected_index == 2)
                    _element.hspd = 9;
            }
            
            array_push(global.elements, _element);
        }
    }
}

if (selected_row != -4)
{
    var _str = asset_obj[selected_row][selected_index];
    draw_set_halign(fa_right);
    draw_text((global.app_xoff + 1408) - 10, 10, _str);
    draw_set_halign(fa_left);
    var _spr = name_to_spr(_str);
    var _w = sprite_get_width(_spr);
    var _h = sprite_get_height(_spr);
    draw_sprite(_spr, 0, (global.app_xoff + 1408) - _w, _h + 32);
}

hello = ["hi", "goodbye"];

if (element_selected != noone)
{
    draw_set_halign(fa_right);
    var _element = global.elements[element_selected];
    
    if (_element.row == 4)
    {
        if (_element.ind == 0)
        {
            draw_text((global.app_xoff + 1408) - 10, 10, $"Channel:{channel_to_str(_element.channel)}");
            draw_text((global.app_xoff + 1408) - 10, 35, $"Wait:{_element.wait}");
        }
        
        if (struct_exists(_element, "spr_change"))
        {
            if (!sprite_exists(asset_get_index(_element.spr_change)))
                draw_set_color(c_red);
            else
                draw_set_color(c_white);
            
            draw_text((global.app_xoff + 1408) - 10, 10, _element.spr_change);
            draw_set_color(c_white);
        }
    }
    else if (_element.row == 5)
    {
        if (struct_exists(_element, "length"))
            draw_text((global.app_xoff + 1408) - 10, 10, $"{_element.length}s");
        
        if (struct_exists(_element, "hspd"))
            draw_text((global.app_xoff + 1408) - 10, 10, $"hspd: {_element.hspd}");
    }
    else if (_element.row == 6)
    {
        if (_element.ind == 0)
        {
            var _snd = _element.snd;
            
            if (!audio_exists(asset_get_index(_snd)))
                draw_set_color(c_red);
            
            draw_text((global.app_xoff + 1408) - 10, 10, $"Clip: {_snd}");
            draw_set_color(c_white);
        }
    }
    
    draw_set_halign(fa_left);
}

var _selected = element_selected;
var _changed = false;
draw_line(global.app_xoff + 1408, obj_controller.bridget_timer + scroll_y, global.app_xoff + 1920, obj_controller.bridget_timer + scroll_y);

if (mx >= 1408)
{
    if (keyboard_check_pressed(ord("L")))
    {
        scroll_cam_lock = !scroll_cam_lock;
    }
    else if (keyboard_check(ord("C")))
    {
        if (!scroll_cam_lock)
            camera_timestamp = my - scroll_y;
    }
}

if (scroll_cam_lock)
    camera_timestamp = obj_controller.bridget_timer;

draw_set_color(c_red);
draw_line(global.app_xoff + 1408, camera_timestamp + scroll_y, global.app_xoff + 1920, camera_timestamp + scroll_y);
draw_set_color(c_white);

for (var i = 0; i < array_length(global.elements); i++)
{
    var _element = global.elements[i];
    draw_sprite_gui_ext(row_spr[_element.row], _element.ind, _element.cx, _element.timestamp + scroll_y, undefined, undefined, undefined, undefined, 0.8);
    _x = global.app_xoff + _element.cx;
    var _y = _element.timestamp + scroll_y;
    
    if (_element.row == 0)
    {
        var _l;
        
        if (struct_exists(_element, "spd"))
        {
            if (_element.spd == 2)
                _l = 41;
            else if (_element.spd == 1)
                _l = 118;
            else if (_element.spd == 0)
                _l = 178;
        }
        
        draw_set_color(col_to_rgb(_element.ind));
        draw_line_width(_x, _y, _x, _y + _l, 3);
        draw_set_color(c_white);
    }
    else if (_element.row == 1)
    {
        var _l = 176;
        draw_line_width(_x, _y, _x, _y + _l, 3);
    }
    else if (_element.row == 4)
    {
        if (_element.ind == 0)
        {
            var _l = _element.wait;
            
            if (_l > 30)
                draw_line_width(_x, _y, _x, _y + _l, 3);
        }
    }
    
    if (_element.row == 5)
    {
        if (_element.ind == 0)
        {
            draw_line_width(_x, _y, _x, _y + 90, 3);
            draw_set_color(c_lime);
            draw_line_width(_x, _y + 90, _x, _y + 90 + 24, 3);
            draw_set_color(c_white);
        }
        else if (_element.ind == 1)
        {
            draw_line_width(_x, _y, _x, _y + (_element.length * 60), 3);
        }
    }
    
    if (point_in_rectangle(mx, my, _element.cx - 32, (_element.timestamp - 32) + scroll_y, _element.cx + 32, _element.timestamp + 32 + scroll_y))
    {
        shader_set(sha_flash);
        draw_sprite_gui_ext(row_spr[_element.row], _element.ind, _element.cx, _element.timestamp + scroll_y, undefined, undefined, undefined, undefined, 0.4);
        shader_reset();
        
        if (mouse_check_button_pressed(mb_left))
        {
            element_selected = i;
            _changed = true;
        }
        
        if (mouse_check_button(mb_right))
        {
            array_delete(global.elements, i, 1);
            
            if (element_selected == i)
                element_selected = noone;
            
            continue;
        }
    }
    
    if (element_selected == i)
    {
        shader_set(sha_flash);
        draw_sprite_gui_ext(row_spr[_element.row], _element.ind, _element.cx, _element.timestamp + scroll_y, undefined, undefined, undefined, undefined, 0.4);
        shader_reset();
    }
    
    if (struct_exists(_element, "mypath") && _element.mypath != noone)
    {
        draw_set_font(fnt_debug);
        draw_sprite_ext(spr_editor_icon_path, 0, _element.cx + 20 + global.app_xoff, (_element.timestamp + scroll_y) - 15, 2, 2, 0, c_white, 0.8);
    }
    
    if (struct_exists(_element, "land_id"))
    {
        draw_set_font(fnt_debug);
        draw_sprite_ext(spr_editor_icon_land, 0, _element.cx + 20 + global.app_xoff, (_element.timestamp + scroll_y) - 15, 2, 2, 0, c_white, 0.8);
        draw_text(_element.cx + 25 + global.app_xoff, (_element.timestamp + scroll_y) - 30, _element.land_id);
    }
    
    if (struct_exists(_element, "wings") && _element.wings)
        draw_sprite(spr_wing, 0, (_element.cx + 20 + global.app_xoff) - 64, (_element.timestamp + scroll_y) - 15);
    
    if (struct_exists(_element, "fat") && _element.fat)
        draw_sprite_ext(spr_editor_icon_fat, 0, _element.cx + 20 + global.app_xoff, (_element.timestamp + scroll_y) - 15, 2, 2, 0, c_white, 0.8);
    
    if (struct_exists(_element, "chute") && _element.chute)
        draw_sprite_ext(spr_editor_icon_chute, 0, _element.cx + 20 + global.app_xoff, (_element.timestamp + scroll_y) - 15, 2, 2, 0, c_white, 0.8);
    
    if (struct_exists(_element, "toggle_pause") && _element.toggle_pause)
        draw_sprite_ext(spr_editor_icon_pause, 0, _element.cx + 20 + global.app_xoff, (_element.timestamp + scroll_y) - 15, 2, 2, 0, c_white, 0.8);
}

if (mouse_check_button_pressed(mb_left) && mx >= 1408)
    _changed = true;

if (_changed && _selected == element_selected)
    element_selected = noone;

if (element_selected != noone)
{
    var _inst = global.elements[element_selected];
    
    if (struct_exists(_inst, "mypath"))
    {
        var x1 = 1011 + global.app_xoff;
        var y1 = 1006;
        draw_set_alpha(0.4);
        draw_rectangle_color(x1, y1, x1 + 397, y1 + 74, c_black, c_black, c_black, c_black, false);
        draw_set_alpha(1);
        x1 = 1034 + global.app_xoff;
        y1 = 1046;
        var _col = 8421504;
        draw_rectangle_color(x1, y1, x1 + 355, y1 + 16, _col, _col, _col, _col, false);
        x1 = 1034 + global.app_xoff + (341 * _inst.path_pos);
        y1 = 1041;
        draw_rectangle(x1, y1, x1 + 14, y1 + 26, false);
        draw_set_font(fnt_debug);
        draw_text(1034 + global.app_xoff, 1017, $"path_pos: {string_format(_inst.path_pos, 3, 2)} / 1.00");
    }
}

toggle_text_draw = "";
event_user(0);
