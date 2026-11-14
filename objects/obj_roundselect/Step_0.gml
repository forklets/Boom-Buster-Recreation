if (!deac && input_check_pressed_all("jump"))
{
    var _selected = selected[menu];
    var _room = rounds[menu][_selected][global.bside];
    
    if (array_contains(global.save.stages_beat, room_get_name(_room)))
    {
        _room = rounds[menu][selected[menu]][global.bside];
        global.round_select_menu = menu;
        global.round_select_selected = selected[menu];
        room_goto_triangles(_room, 60);
        audio_stop_all();
        audio_play_sound(snd_kaching, 0, false);
        deac = true;
    }
    else
    {
        audio_stop_play(snd_wrong, 0, false);
    }
}

if (deac)
    exit;

if (input_check_pressed_all(global.input_menu_special) && global.save.campaign_beat_A)
{
    global.player_character[0] = !global.player_character[0];
    bar_shake = 1;
    
    if (audio_is_playing(voice_play))
        audio_stop_sound(voice_play);
    
    var _voice;
    
    if (global.player_character[0] == 1)
        _voice = voice_bridget_ohok;
    else
        _voice = voice_buster_ohmygod;
    
    voice_play = audio_play_sound(_voice, 0, false);
}

var _xAxis = input_check_pressed_all("right") - input_check_pressed_all("left");
var _yAxis = input_check_pressed_all("down") - input_check_pressed_all("up");
menu += _xAxis;
menu = clamp(menu, 0, array_length(rounds) - 1);
var _max = array_length(rounds[menu]) - 1;
selected[menu] += _yAxis;

if (selected[menu] > _max)
    selected[menu] = 0;

if (selected[menu] < 0)
    selected[menu] = _max;

if (input_check_pressed_all("spin") || input_check_pressed_all("back"))
{
    input_verb_consume_all("spin");
    input_verb_consume_all("back");
    deac = true;
    instance_destroy();
}

bar_shake = approach(bar_shake, 0, 1/15);
