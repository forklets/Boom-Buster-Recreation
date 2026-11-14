event_inherited();
options = ["NEW GAME", "CONTINUE"];

var _newgame = function()
{
    global.save.last_room_A = noone;
    global.save.dollars_A = 0;
    global.save.deaths_A = 0;
    audio_stop_all();
    audio_play_sound(snd_kaching, 0, false);
    room_goto_triangles(rm_cutscene_opening, 180);
    deac = true;
};

var _continue = function()
{
    var _side;
    
    if (global.bside)
        _side = "B";
    else
        _side = "A";
    
    var _room = variable_struct_get(global.save, $"last_room_{_side}");
    _room = asset_get_index(_room);
    global.dollars = variable_struct_get(global.save, $"dollars_{_side}");
    audio_stop_all();
    audio_play_sound(snd_kaching, 0, false);
    
    if (global.save.campaign_beat_A && _room != noone && !array_contains(global.cutscene_rooms, _room))
    {
        global.next_room = _room;
        _room = rm_charselect;
    }
    
    room_goto_triangles(_room, 180);
    deac = true;
};

options_event = [_newgame, _continue];
xoff = 729;
yoff = -158;
box = false;
ready = true;
options_draw_max = array_length(options);
