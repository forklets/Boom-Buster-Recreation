if (!global.debug)
    exit;

mx = window_mouse_get_x();
my = window_mouse_get_y();

if (keyboard_check_pressed(vk_f1))
    edit_mode = !edit_mode;

if (!edit_mode)
    exit;

if (keyboard_check(vk_shift))
{
    grid_x = 16;
    grid_y = 16;
}
else
{
    grid_x = 32;
    grid_y = 32;
}

if (keyboard_check_pressed(ord("V")))
    view_all = !view_all;

if (keyboard_check_pressed(ord("U")))
    display_ui = !display_ui;

var _element;

if (element_selected != noone)
    _element = global.elements[element_selected];

if (keyboard_check_pressed(ord("I")) && element_selected != noone)
{
    if (_element.row == 0)
    {
        _element.spd++;
        
        if (_element.spd > 2)
            _element.spd = 0;
    }
}

if (keyboard_check_pressed(ord("G")))
{
    grid_x = get_integer($"grid_x:{grid_x}", "");
    grid_y = get_integer($"grid_y:{grid_y}", "");
}

if (keyboard_check_pressed(ord("P")) && element_selected != noone)
{
    var _str = get_string("Enter Path Asset Name", "");
    
    if (path_exists(asset_get_index(_str)))
    {
        _element.mypath = _str;
        _element.path_pos = 0;
        show_message("Path Set!");
        _element.x = path_get_x(asset_get_index(_str), 0);
        _element.y = path_get_y(asset_get_index(_str), 0);
    }
    else if (struct_exists(_element, "mypath"))
    {
        struct_remove(_element, "mypath");
    }
}

if (keyboard_check_pressed(ord("C")) && element_selected != noone)
{
    var _str = get_string("Change BOM Color\nColor = Row Index\ne.g. 0 = Orange, 1 = Cyan, so on...", _element.ind);
    _element.ind = real(_str);
}

if (keyboard_check_pressed(ord("L")) && element_selected != noone)
{
    var _str = get_integer("Enter Landing ID", "");
    
    if (_str != noone)
        _element.land_id = _str;
    else if (struct_exists(_element, "land_id"))
        struct_remove(_element, "land_id");
}

if (keyboard_check_pressed(ord("1")))
{
    var _col0 = get_string("Before Col", "");
    
    if (_col0 == "")
        exit;
    
    var _col1 = get_string("After Col", "");
    
    if (_col1 == "")
        exit;
    
    _col0 = real(_col0);
    _col1 = real(_col1);
    
    for (var i = 0; i < array_length(global.elements); i++)
    {
        _element = global.elements[i];
        
        if (_element.row == 0)
        {
            if (_element.ind == _col0)
                _element.ind = _col1;
        }
        else if (_element.row == 2 && _element.ind == 6)
        {
            if (!struct_exists(_element, "col"))
                _element.col = 0;
            
            if (_element.col == _col0)
                _element.col = _col1;
        }
    }
}

if (keyboard_check_pressed(vk_space) && element_selected != noone)
{
    var _items = ["obj_gem", "obj_bom_swap", "obj_key", "obj_bom_anxious"];
    
    if (array_contains(_items, asset_obj[_element.row][_element.ind]))
    {
        if (keyboard_check_pressed(vk_space))
        {
            if (!struct_exists(_element, "col"))
                _element.col = 0;
            
            _element.col++;
            
            if (_element.col > 4)
                _element.col = 0;
        }
    }
    else if (_element.row == 4)
    {
        if (_element.ind == 0)
        {
            if (keyboard_check(vk_shift))
            {
                var _str = get_integer("Enter Channel Wait", "");
                
                if (_str != noone)
                    _element.wait = _str;
                else
                    _element.wait = -4;
            }
            else
            {
                var _str = get_integer("Enter Channel ID", "");
                
                if (_str != noone)
                    _element.channel = _str;
                else
                    _element.channel = -4;
            }
        }
        else if (_element.ind == 1)
        {
            var _str = get_string("Enter Bridget Sprite", "");
            
            if (_str != noone)
                _element.spr_change = _str;
            else
                _element.spr_change = noone;
        }
        else if (_element.ind == 2)
        {
            var _str = get_string("Enter Wizard Sprite", "");
            
            if (_str != noone)
                _element.spr_change = _str;
            else
                _element.spr_change = noone;
        }
    }
    
    if (_element.row == 5)
    {
        if (_element.ind == 1)
        {
            var _str = get_integer("Enter Lights-Out Length\n(In Seconds Not Frames)", "");
            
            if (_str != noone)
                _element.length = _str;
            else
                _element.length = 2;
        }
        else if (_element.ind == 2)
        {
            var _str = get_integer("Enter Fireball HSPD", "");
            
            if (_str != noone)
                _element.hspd = _str;
            else
                _element.hspd = 2;
        }
    }
    
    if (_element.row == 6)
    {
        if (_element.ind == 0)
        {
            var _str = get_string("Enter Sound Name", "");
            
            if (_str != noone)
                _element.snd = _str;
            else
                _element.snd = "undefined";
        }
    }
}

var _yAxis = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);

if (_yAxis != 0 && element_selected != noone)
{
    if (keyboard_check(ord("K")))
        _element.timestamp += (_yAxis * 60) / 3;
    else if (keyboard_check(vk_shift))
        _element.timestamp += _yAxis * 30;
    else
        _element.timestamp += _yAxis * 60;
}

var _xAxis = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);

if (_xAxis != 0 && element_selected != noone)
{
    if (keyboard_check(vk_shift))
        _element.cx += _xAxis * 40;
    else
        _element.cx += _xAxis * 20;
}

if (keyboard_check_pressed(ord("T")) && element_selected != noone)
{
    var _int = get_integer("", "Enter Second (NOT Game Frame)") * 60;
    
    if (is_numeric(_int))
        _element.timestamp = _int;
}

if (keyboard_check_pressed(ord("P")) && element_selected == noone)
{
    if (keyboard_check(vk_shift))
    {
        var _str = "Delete an array?\n \n \n";
        var i;
        
        for (i = 0; i < array_length(obj_controller.paths); i++)
        {
            var _new = $"{i}. {obj_controller.paths[i]}\n";
            var _len = string_length(_str);
            _str = string_insert(_new, _str, _len);
        }
        
        var _delete = get_string(_str, "");
        
        if (_delete != "")
            array_delete(obj_controller.paths, _delete, i);
    }
    else
    {
        var _name = get_string("New Path Name", "");
        
        if (_name != "")
        {
            var _spd = real(get_string("New Path Speed", 0.0135));
            var _ease = real(get_string("New Path Ease", 2));
            array_push(obj_controller.paths, 
            {
                name: _name,
                spd: _spd,
                ease: _ease
            });
        }
    }
}

if (keyboard_check_pressed(vk_enter))
{
    var _data = 
    {
        bgm: audio_get_name(obj_controller.bgm),
        name: global.act_name,
        bossfight: obj_controller.bossfight,
        stage_event: obj_controller.stage_event,
        paths: obj_controller.paths,
        elements: global.elements
    };
    var _str = json_stringify(_data, true);
    var _open = file_text_open_write(get_save_filename("*.json", ""));
    file_text_write_string(_open, _str);
    file_text_close(_open);
}

if (keyboard_check_pressed(ord("N")))
    global.act_name = get_string("Enter Level Name", global.act_name);

if (keyboard_check_pressed(ord("E")))
{
    var _str = get_string("Stage Event\n\nwizard = Wizard Mini-Boss", obj_controller.stage_event);
    
    if (_str != "")
        obj_controller.stage_event = _str;
}

if (keyboard_check_pressed(ord("M")))
{
    var _str = get_string("Enter Song Name", audio_get_name(obj_controller.bgm));
    var _asset = asset_get_index(_str);
    
    if (audio_exists(_asset))
    {
        obj_controller.bgm = _asset;
        
        if (audio_is_playing(global.bgmPlay))
            audio_stop_sound(global.bgmPlay);
        
        global.bgmPlay = audio_play_sound(obj_controller.bgm, 0, true);
    }
}

var x1 = 1011;
var y1 = 1006;
var x2 = x1 + 397;
var y2 = y1 + 74;

if (element_selected != noone && struct_exists(_element, "mypath") && point_in_rectangle(mx, my, x1, y1, x2, y2))
{
    if (mouse_wheel_down())
        _element.path_pos -= 0.01 + (0.03 * keyboard_check(vk_shift));
    
    if (mouse_wheel_up())
        _element.path_pos += 0.01 + (0.03 * keyboard_check(vk_shift));
    
    if (_element.path_pos < 0)
        _element.path_pos = 1;
    
    if (_element.path_pos > 1)
        _element.path_pos = 0;
}
else
{
    if (mouse_wheel_down())
        scroll_y -= (30 + (30 * (keyboard_check(vk_shift) * 8)));
    
    if (mouse_wheel_up())
        scroll_y += (30 + (30 * (keyboard_check(vk_shift) * 8)));
}
