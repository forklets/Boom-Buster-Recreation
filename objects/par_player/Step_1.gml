if (instance_exists(obj_round_clear_select))
    exit;

xAxisBefore = xAxis;
var _input = (global.players > 1) ? input_check : input_check_all;
xAxis = _input("right", player) - _input("left", player);
yAxis = _input("down", player) - _input("up", player);

if (!set_char)
{
    char = global.player_character[player];
    char_reload();
    set_char = true;
}
