var _trans = room_goto_triangles(room);

_trans.func_roomend = function()
{
    global.dollars = global.dollars_start;
    global.combo_meter = global.combo_meter_start;
    global.food[global.act] = false;
};
