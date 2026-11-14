draw_set_font(fnt_debug);
var _x = 10;
var _y = 10;
draw_text(_x, _y, $"<({menu + 1}/{array_length(rooms)})> MENU");
_y += 15;
var _stagePrev = "na";

for (var i = 0; i < array_length(rooms[menu]); i++)
{
    var _sep = 28;
    _x = 10;
    
    if (selected == i)
        _x += 15;
    
    _y += _sep;
    
    if (selected == i)
        draw_set_color(c_yellow);
    else
        draw_set_color(c_white);
    
    var _name = room_get_name(rooms[menu][i]);
    draw_text(_x, _y, _name);
    draw_set_color(c_white);
}

_x = 500;
_y = 10;
draw_text(_x, _y, $"players: {global.players} (M)");
_y += 20;
var _finished = input_join_is_finished();

if (_finished)
    draw_set_color(c_lime);
else
    draw_set_color(c_red);

draw_text(_x, _y, $"READY: {input_join_is_finished()}");
draw_set_color(c_white);
_y += 50;

for (var i = 0; i < global.players; i++)
{
    var _source = input_source_get_array(i);
    draw_set_color(make_colour_hsv(22 + (i * 110), 200, 255));
    draw_text(_x, _y, $"PLAYER {i}: {_source}");
    _y += 20;
}

draw_set_color(c_white);
_x = 1000;
_y = 10;

for (var i = 0; i < 2; i++)
{
    if (keyboard_check_pressed(ord(string(i + 1))))
        global.player_character[i] = !global.player_character[i];
    
    draw_text(_x, _y, $"Character [P{i + 1}]: {global.player_character[i]} ({i + 1})");
    _y += 20;
}

_x = 1400;
_y = 10;

for (var i = 0; i < 2; i++)
{
    draw_text(_x, _y, $"B-Side: {global.bside}");
    _y += 20;
}
