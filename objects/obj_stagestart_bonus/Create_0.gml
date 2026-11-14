if (global.round_select)
    go = 1;
else
    go = 4;

go_scale = 2;
go_alpha = 0;
go_percent = 0;
timer[0] = 80;

timer_func[0] = function()
{
    go--;
    go_percent = 0;
    
    if (go == -1)
    {
        var _bgm;
        
        if (global.bside)
            _bgm = bgm_bonus_b;
        else
            _bgm = bgm_bonus;
        
        global.bgmPlay = audio_play_sound(_bgm, 0, true);
        
        with (obj_bonus_controller)
            event_unfreeze();
        
        instance_destroy();
    }
    else if (go == 0)
    {
        timer[0] = 50;
        audio_play_sound(snd_wrongbuzzer, 0, false);
    }
    else
    {
        timer[0] = 50;
        audio_stop_play(snd_coin, 0, false);
    }
};
