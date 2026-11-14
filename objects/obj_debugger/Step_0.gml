var _max = array_length(rooms[menu]) - 1;
xAxis = input_check_pressed_all("right") - input_check_pressed_all("left");
yAxis = input_check_pressed_all("down") - input_check_pressed_all("up");
selected += yAxis;

if (selected < 0)
    selected = _max;

if (selected > _max)
    selected = 0;

if (input_check_pressed_all("jump"))
{
    if (menu == 1)
        global.bside = false;
    else if (menu == 2)
        global.bside = true;
    
    global.stage_load = undefined;
    global.acts = 1;
    global.act_name = "Undefined";
    var _room = rooms[menu][selected];
    
    if (!room_exists(_room))
    {
        show_message($"Room Does Not Exist: {_room}");
        exit;
    }
    
    room_goto(_room);
    exit;
}

if (keyboard_check_pressed(ord("R")))
    room_restart();

_max = array_length(rooms) - 1;

if (xAxis != 0)
{
    menu += xAxis;
    
    if (menu < 0)
        menu = _max;
    
    if (menu > _max)
        menu = 0;
    
    selected = 0;
}

if (keyboard_check_pressed(ord("B")))
    global.bside = !global.bside;

if (keyboard_check_pressed(ord("M")))
{
    global.players++;
    
    if (global.players > 2)
        global.players = 1;
}
