global.bubble = false;
global.combo_meter = 0;

if (keyboard_check_pressed(ord("R")) && global.debug)
{
    audio_stop_all();
    room_restart();
}

if (!ended && !instance_exists(obj_stagestart_bonus))
    time -= 0.016666666666666666;

if (instance_exists(obj_player_death))
    time = 0;

if (global.debug && keyboard_check_pressed(ord("H")))
    time = 0.1;

if ((time <= 0 || !instance_exists(obj_crate)) && !ended)
{
    ended = true;
    
    if (audio_is_playing(global.bgmPlay))
        audio_stop_sound(global.bgmPlay);
    
    audio_play_sound(snd_wrongbuzzer, 0, false);
    
    for (var i = 0; i < array_length(freeze_objects); i++)
    {
        with (freeze_objects[i])
            bonus_freeze = true;
    }
    
    with (par_player)
        squish_percent = 1;
    
    timer[0] = 90;
}

if (!screen_results)
{
    if (keyboard_check_pressed(ord("J")) && global.debug)
    {
        with (obj_crate)
            event_break();
    }
}

if (!ended || exit_freeze())
    exit;

if (screen_results)
{
    overlay_alpha = approach(overlay_alpha, 0.775, 0.05);
    
    if (keyboard_check_pressed(ord("G")) && global.debug)
    {
        coins_tallied = 0;
        timer[1] = 6;
        bonus = false;
    }
}

coin_y += coin_vspd;
coin_vspd += coin_grav;
coin_y = min(coin_y, 500);
coin_vspd = min(coin_vspd, 500);
var _rows = -1;

for (var i = 0; i < coins_tallied; i++)
{
    if ((i % 8) == 0)
        _rows++;
}

coin_dist_real = 48 * _rows;
coin_dist_smooth = easy_smooth(coin_dist_smooth, coin_dist_real, 2);

if (coins_tallied >= global.coins_collected)
{
    if (!bonus && timer[2] == -1)
        timer[2] = 90;
}

if (ease_timer > -1)
    ease_timer = clamp(ease_timer + 0.01, 0, 1);

scale_ease = 2 - easeOutElastic(ease_timer);
text_y = easy_smooth(text_y, 945, 2);
timer_logic(0);
timer_logic(1);
timer_logic(2);
timer_logic(3);
timer_logic(4);

if (go)
{
    go_alpha = approach(go_alpha, 1, 0.05);
    
    if (input_check_pressed_all("jump") && !left_room)
    {
        var _room;
        
        if (room == rm_bonus_1 || room == rm_bonus_b1)
            _room = rm_cutscene_city;
        else if (room == rm_bonus_2 || room == rm_bonus_b2)
            _room = rm_cutscene_mall;
        else if (room == rm_bonus_3 || room == rm_bonus_b3)
            _room = rm_cutscene_factory;
        
        if (global.round_select)
            _room = rm_title;
        
        if (audio_is_playing(bgm_play))
            audio_sound_gain(bgm_play, 0, 1500);
        
        left_room = true;
        room_goto_triangles(_room, 150);
    }
}
