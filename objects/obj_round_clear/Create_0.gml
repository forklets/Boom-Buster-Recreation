if (room == rm_round_7_3)
    scr_get_achievement("TOWER_1");
else if (room == rm_round_b7_3)
    scr_get_achievement("TOWER_1B");
else if (room == rm_round_14_3)
    scr_get_achievement("TOWER_2");
else if (room == rm_round_b14_3)
    scr_get_achievement("TOWER_2B");
else if (room == rm_round_21_3)
    scr_get_achievement("TOWER_3");
else if (room == rm_round_b21_3)
    scr_get_achievement("TOWER_3B");
else if (room == rm_outskirts_3)
    scr_get_achievement("OUTSKIRTS");
else if (room == rm_outskirts_b3)
    scr_get_achievement("OUTSKIRTS_B");

hue = 0;
in_tutorial = array_contains(global.stages_tutorial, room);

if (in_tutorial)
    y = -100;
else
    y = -240;

win_pose = false;

if (!array_contains(global.save.stages_beat, room_get_name(room)))
{
    var _room = room;
    
    if (room == rm_round_7_3)
        _room = rm_round_7_1;
    else if (room == rm_round_b7_3)
        _room = rm_round_b7_1;
    else if (room == rm_round_14_3)
        _room = rm_round_14_1;
    else if (room == rm_round_b14_3)
        _room = rm_round_b14_1;
    else if (room == rm_round_21_3)
        _room = rm_round_21_1;
    else if (room == rm_round_b21_3)
        _room = rm_round_b21_1;
    
    array_push(global.save.stages_beat, room_get_name(_room));
}

if (room == rm_round_7_3 || room == rm_round_14_3 || room == rm_round_21_3 || room == rm_round_b7_3 || room == rm_round_b14_3 || room == rm_round_b21_3 || room == rm_outskirts_3 || room == rm_outskirts_b3)
{
    voice_asset = voice_announcer_boss;
}
else
{
    var _voices = [];
    var _voices_buster = [voice_buster_coins_nomnom, voice_buster_urprettygoodatthisgame, voice_buster_iloveyou, voice_buster_yeahcreepy_alt, voice_buster_yeahcreepy, voice_buster_ilikethat, voice_buster_heythatsprettygood, voice_buster_datswicked, voice_buster_alright, voice_buster_ohmygod, voice_buster_laugh, voice_buster_notbad];
    var _voices_bridget = [voice_bridget_omgthatssodecent, voice_bridget_talkinabout, voice_bridget_okicu, voice_bridget_heheyay, voice_bridget_holyshit, voice_bridget_progameralert];
    
    if (global.players > 1)
    {
        _voices = array_concat(_voices, _voices_buster);
        _voices = array_concat(_voices, _voices_bridget);
    }
    else if (global.player_character[0] == 0)
    {
        _voices = array_concat(_voices, _voices_buster);
    }
    else
    {
        _voices = array_concat(_voices, _voices_bridget);
    }
    
    voice_asset = _voices[irandom_range(0, array_length(_voices) - 1)];
}

if (in_tutorial)
    voice_asset = noone;

audio_sound_gain(snd_explosion, 0, 300);
var _snd = audio_play_sound(snd_powerup, 0, false);
audio_sound_pitch(_snd, 1.2);
timer[0] = 255;

timer_func[0] = function()
{
    var _notdone = [rm_round_7_1, rm_round_7_2, rm_round_b7_1, rm_round_b7_2, rm_round_14_1, rm_round_14_2, rm_round_b14_1, rm_round_b14_2, rm_round_21_1, rm_round_21_2, rm_round_b21_1, rm_round_b21_2, rm_final_scroll, rm_final_scroll_b];
    
    if (global.round_select && !array_contains(_notdone, room))
    {
        instance_create_layer(0, 0, "GUI", obj_round_clear_select);
    }
    else
    {
        with (obj_controller)
            timer_func[timer_win]();
    }
};

timer[1] = 2;

timer_func[1] = function()
{
    win_pose = true;
};

timer[2] = 50;

timer_func[2] = function()
{
    slide_msg = true;
};

timer[3] = 42;

timer_func[3] = function()
{
    if (audio_exists(voice_asset))
    {
        voice_play = audio_play_sound(voice_asset, 0, false);
        audio_sound_gain(voice_play, 2, 0);
    }
    else
    {
        voice_play = noone;
    }
};

timer[4] = -1;

timer_func[4] = function()
{
    audio_play_sound(snd_coin, 0, false);
    checkmark = true;
};

checkmark = false;

if (in_tutorial)
    timer[4] = 40;

percent_checkmark = 0;
slide_msg = false;
image_alpha = 0;
slide_x = -1350;

if (array_contains(global.stages_final, room))
    slide_x -= 256;

msg = "";

if (obj_controller.stage_event != "wizard" || (array_contains(global.stages_outskirts, room) && (room != rm_outskirts_3 && room != rm_outskirts_b3)))
{
    msg = "";
    timer[0] = 210;
}

msg = $"DEATHS: {global.deaths}";
scr_set_highscore();

if (global.food_got && !array_contains(global.save.round_foods, room_get_name(room)))
{
    array_push(global.save.round_foods, room_get_name(room));
    var _all = [rm_round_1, rm_round_2, rm_round_3, rm_round_4, rm_round_5, rm_round_6, rm_round_8, rm_round_9, rm_round_10, rm_mall_extra1, rm_round_11, rm_round_12, rm_round_13, rm_round_15, rm_round_16, rm_round_17, rm_round_18, rm_factory_extra1, rm_round_19, rm_round_20, rm_outskirts_1, rm_outskirts_2, rm_outskirts_3];
    var _got = true;
    
    for (var i = 0; i < array_length(_all); i++)
    {
        if (!array_contains(global.save.round_foods, _all[i]))
        {
            _got = false;
            break;
        }
    }
    
    if (_got)
        scr_get_achievement("FOOD");
    
    _all = [rm_round_b1, rm_round_b2, rm_round_b3, rm_round_b4, rm_round_b5, rm_round_b6, rm_round_b8, rm_round_b9, rm_round_b10, rm_mall_extrab1, rm_round_b11, rm_round_b12, rm_round_b13, rm_round_b15, rm_round_b16, rm_round_b17, rm_round_b18, rm_factory_extrab1, rm_round_b19, rm_round_b20, rm_outskirts_b1, rm_outskirts_b2, rm_outskirts_b3];
    _got = true;
    
    for (var i = 0; i < array_length(_all); i++)
    {
        if (!array_contains(global.save.round_foods, _all[i]))
        {
            _got = false;
            break;
        }
    }
    
    if (_got)
        scr_get_achievement("FOOD_B");
}

if (global.round_select)
{
    with (obj_persistent)
        event_save();
}

if (in_tutorial)
{
    timer[2] = -1;
    timer[0] = 135;
}
