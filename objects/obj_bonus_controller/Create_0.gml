event_unfreeze = function()
{
    for (var i = 0; i < array_length(freeze_objects); i++)
    {
        with (freeze_objects[i])
            bonus_freeze = false;
    }
};

freeze_objects = [par_player, par_enemy, obj_buzzsaw];
alarm[0] = 2;
go_alpha = 0;

if (global.bside)
    time = 20;
else
    time = 20;

ended = false;
bgm_play = noone;
timer[0] = -1;

timer_func[0] = function()
{
    if (instance_exists(obj_player_death))
        global.coins_collected = 0;
    
    screen_results = true;
    bgm_play = audio_play_sound(bgm_results, 0, true);
    timer[1] = 90;
};

coin_jump = 10.25;
coin_grav = 1.6;
coin_vspd = 0;
coin_y = 0;
coin_dist_real = 0;
coin_dist_smooth = 0;
epic_fail = false;
timer[1] = -1;

timer_func[1] = function()
{
    var _tallied = coins_tallied;
    
    if (global.coins_collected == 0)
    {
        epic_fail = true;
        audio_play_sound(snd_wrong, 0, false);
        var _voices_buster = [voice_buster_phony, voice_buster_thehorror, voice_buster_doomeddammit];
        var _voices_bridget = [voice_bridget_straightbuns, voice_bridget_umok, voice_bridget_yousuckatthisshit];
        var _voices = [];
        
        if (global.players == 2)
        {
            _voices = array_concat(_voices, _voices_buster);
            _voices = array_concat(_voices, _voices_bridget);
        }
        else if (global.player_character[0] == 0)
        {
            _voices = _voices_buster;
        }
        else
        {
            _voices = _voices_bridget;
        }
        
        var _choose = irandom_range(0, array_length(_voices) - 1);
        audio_play_sound_delay(_voices[_choose], 20);
        timer[4] = 90;
    }
    else if (_tallied < global.coins_collected)
    {
        coins_tallied++;
        audio_stop_play(snd_coin, 0, false);
        timer[1] = 7;
        coin_y = 0;
        coin_vspd = -coin_jump;
        timer[3] = 2;
        
        if (coins_tallied == (global.coins_collected - 1))
            timer[2] = 90;
    }
};

timer[3] = -1;

timer_func[3] = function()
{
};

left_room = false;
ok_sound_played = false;
bonus = false;
timer[2] = -1;

timer_func[2] = function()
{
    text_y = 1200;
    
    if (instance_exists(obj_crate))
    {
        if (global.coins_collected != 0)
            timer[4] = 10;
        
        if (!ok_sound_played && global.coins_collected != 0)
        {
            _voices_buster = [voice_buster_illgiveuthatone];
            _voices_bridget = [voice_bridget_omgthatssodecent];
            _voices = [];
            
            if (global.players == 2)
            {
                _voices = array_concat(_voices, _voices_buster);
                _voices = array_concat(_voices, _voices_bridget);
            }
            else if (global.player_character[0] == 0)
            {
                _voices = _voices_buster;
            }
            else
            {
                _voices = _voices_bridget;
            }
            
            _choose = irandom_range(0, array_length(_voices) - 1);
            audio_play_sound(_voices[_choose], 0, false);
            ok_sound_played = true;
        }
        
        exit;
    }
    
    audio_play_sound(snd_powerup, 0, false);
    var _voices_buster = [voice_buster_incredible];
    var _voices_bridget = [voice_bridget_progameralert];
    var _voices = [];
    
    if (global.players == 2)
    {
        _voices = array_concat(_voices, _voices_buster);
        _voices = array_concat(_voices, _voices_bridget);
    }
    else if (global.player_character[0] == 0)
    {
        _voices = _voices_buster;
    }
    else
    {
        _voices = _voices_bridget;
    }
    
    var _choose = irandom_range(0, array_length(_voices) - 1);
    audio_play_sound_delay(_voices[_choose], 30);
    bonus = true;
    ease_timer = 0;
    score_add(50);
    timer[4] = 90;
    
    if (room == rm_bonus_1)
        scr_get_achievement("BONUS_1");
    else if (room == rm_bonus_2)
        scr_get_achievement("BONUS_2");
    else if (room == rm_bonus_3)
        scr_get_achievement("BONUS_3");
    else if (room == rm_bonus_b1)
        scr_get_achievement("BONUS_1B");
    else if (room == rm_bonus_b2)
        scr_get_achievement("BONUS_2B");
    else if (room == rm_bonus_b3)
        scr_get_achievement("BONUS_3B");
};

timer[4] = -1;

timer_func[4] = function()
{
    go = true;
};

go = false;
text_y = 1200;
text_perfect = scr_text_setup("PERFECT!! + $50.00 /");
text_50 = scr_text_setup("          + $50.00/");
screen_results = false;
overlay_alpha = 0;
coins_tallied = 0;
scale_ease = 2;
ease_timer = -1;

easeOutElastic = function(arg0)
{
    var c4 = 2.0943951023931953;
    return (arg0 == 0) ? 0 : ((arg0 == 1) ? 1 : ((power(2, -10 * arg0) * sin(((arg0 * 10) - 0.75) * c4)) + 1));
};

if (!array_contains(global.save.stages_beat, room_get_name(room)))
    array_push(global.save.stages_beat, room_get_name(room));
