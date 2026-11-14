event_inherited();

if (array_contains(global.stages_final, room))
    xoff = 256;

options = ["PLAY AGAIN", "RETURN"];

var _again = function()
{
    deac = true;
    audio_play_sound(snd_kaching, 0, false);
    var _room = room;
    var _rooms = [[rm_round_7_3, rm_round_7_1], [rm_round_b7_3, rm_round_b7_1], [rm_round_14_3, rm_round_b14_1], [rm_round_b14_3, rm_round_b14_1], [rm_round_21_3, rm_round_21_1], [rm_round_b21_3, rm_round_b21_1], [rm_final, rm_final_scroll], [rm_final_b, rm_final_scroll_b]];
    
    for (var i = 0; i < array_length(_rooms); i++)
    {
        if (room == _rooms[i][0])
        {
            _room = _rooms[i][1];
            break;
        }
    }
    
    var _trans = room_goto_triangles(_room);
    
    _trans.func_roomend = function()
    {
        global.deaths = 0;
        global.dollars = 0;
        global.dollars_start = 0;
        global.food_got = false;
        global.blood = [];
        global.combo_meter = 0;
        global.combo_meter_start = 0;
        
        if (array_contains(global.stages_final, room))
        {
            obj_persistent.shake_strength[0] = 0;
            obj_persistent.shake_strength[1] = 0;
            audio_stop_all();
        }
    };
};

var _back = function()
{
    deac = true;
    audio_play_sound(snd_kaching, 0, false);
    room_goto_triangles(rm_title);
    audio_sound_gain(global.bgmPlay, 0, 800);
};

options_event = [_again, _back];
xoff = 0;
yoff = 100;
box = false;
ready = true;
options_draw_max = array_length(options);

if (array_contains(global.stages_final, room))
    xoff = 256;
