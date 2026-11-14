event_inherited();

var _play = function()
{
    deac = true;
    var _room;
    
    if (global.bside)
        _room = global.save.last_room_B;
    else
        _room = global.save.last_room_A;
    
    if (_room == noone)
    {
        var _trans = room_goto_triangles(rm_cutscene_opening, 180);
        
        _trans.func_roomend = function()
        {
            audio_stop_all();
        };
        
        audio_play_sound(snd_kaching, 0, false);
        
        if (audio_is_playing(global.bgm_play))
            audio_sound_gain(global.bgm_play, 0, 1600);
    }
    else
    {
        instance_create_layer(0, 0, layer, obj_title_newgame);
        deac = true;
    }
};

var _side = function()
{
    if (!global.save.campaign_beat_A)
    {
        audio_stop_play(snd_wrong, 0, false);
    }
    else
    {
        global.bside = !global.bside;
        audio_stop_play(snd_blood, 0, false);
        bar_shake = 1;
    }
};

var _select = function()
{
    var _inst = instance_create_layer(0, 0, layer, obj_roundselect);
};

var _options = function()
{
    var _inst = instance_create_layer(0, 0, layer, obj_options);
    _inst.xoff = 200;
};

var _highscore = function()
{
    var _inst = instance_create_layer(0, 0, layer, obj_results);
};

var _quit = function()
{
    game_end();
};

var _extras = function()
{
    var _inst = instance_create_layer(0, 0, layer, obj_title_extras);
};

options = ["CAMPAIGN", "SIDE: A", "ROUND SELECT", "HIGHSCORES", "EXTRAS", "OPTIONS", "QUIT"];
options_event = [_play, _side, _select, _highscore, _extras, _options, _quit];
xoff = 729;
yoff = -158;
box = false;
ready = true;
options_draw_max = array_length(options);
