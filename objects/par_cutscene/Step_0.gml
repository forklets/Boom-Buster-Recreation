skip_alpha -= 0.01;

if (input_check_pressed("start"))
{
    if (global.theater != noone)
    {
        room_goto(rm_title);
    }
    else if (global.save.campaign_beat_A)
    {
        deac = true;
        event_room_end();
        
        if (audio_is_playing(bgm_play))
            audio_sound_gain(bgm_play, 0, 800);
    }
}

if (input_check_pressed_all("jump") && !deac && !go)
{
    if (slide != (array_length(texts) - 1))
    {
        go = true;
        text_y_start = text_y;
    }
    
    event_on_press();
}

if (go)
{
    var _dest = text_y_start - text_sep;
    text_y = approach(text_y, _dest, text_sep / 20);
    
    if (text_y == _dest)
    {
        slide++;
        slide_check();
        go = false;
        arrow_move = false;
        timer[0] = arrow_move_delay;
    }
}

timer_logic(0);
timer_logic(1);
