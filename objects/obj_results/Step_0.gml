timer_logic(0);

if (global.debug && keyboard_check_pressed(ord("R")))
{
    audio_stop_all();
    room_restart();
}

flash_delay--;
var _pressed = false;

if (room == rm_title && (input_check_pressed_all("spin") || input_check_pressed_all("back")))
    _pressed = true;

if (room == rm_results && input_check_pressed_all("jump"))
    _pressed = true;

if (done && _pressed)
{
    if (room == rm_title)
    {
        instance_destroy();
    }
    else
    {
        var _to;
        
        if (first_beat)
            _to = rm_youcannow;
        else
            _to = rm_title;
        
        var _room = room_goto_fade(_to, 120);
        
        _room.func_roomend = function()
        {
            audio_stop_all();
        };
        
        if (audio_is_playing(bgm_play))
            audio_sound_gain(bgm_play, 0, 1500);
        
        if (audio_is_playing(voice_play))
            audio_sound_gain(voice_play, 0, 1500);
    }
}

if (new_highscore && !done)
{
    var _xAxis = input_check_pressed_all("right") - input_check_pressed_all("left");
    
    if (keyboard_check_pressed(vk_backspace))
        _xAxis = -1;
    
    initial_index += _xAxis;
    initial_index = clamp(initial_index, 0, 2);
    var _yAxis = input_check_pressed_all("down") - input_check_pressed_all("up");
    
    if (_yAxis != 0)
    {
        flash_delay = 35;
        var _scroll;
        
        for (var i = 0; i < array_length(initials_list); i++)
        {
            if (string_char_at(my_score[0], initial_index + 1) == initials_list[i])
            {
                _scroll = i;
            }
            else
            {
            }
        }
        
        _scroll += _yAxis;
        
        if (_scroll > (array_length(initials_list) - 1))
            _scroll = 0;
        
        if (_scroll < 0)
            _scroll = array_length(initials_list) - 1;
        
        var _new_chr = initials_list[_scroll];
        my_score[0] = string_delete(my_score[0], initial_index + 1, 1);
        my_score[0] = string_insert(_new_chr, my_score[0], initial_index + 1);
    }
    
    if (input_check_pressed_all("jump"))
    {
        initial_index++;
        
        if (initial_index == 3)
        {
            done = true;
            audio_play_sound(snd_powerup, 0, false);
            var _data = {};
            _data.highscores = highscores;
            var _look;
            
            if (global.bside)
                _look = game_save_id + "highscoresB.json";
            else
                _look = game_save_id + "highscores.json";
            
            var _str = json_stringify(_data, true);
            var _open = file_text_open_write(_look);
            file_text_write_string(_open, _str);
            file_text_close(_open);
        }
    }
}
