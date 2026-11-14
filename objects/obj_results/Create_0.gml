if (room != rm_title)
    audio_stop_all();

if (room == rm_results)
{
    var _side;
    
    if (global.bside)
        _side = "B";
    else
        _side = "A";
    
    var _deaths;
    
    if (global.bside)
        _deaths = global.save.deaths_B;
    else
        _deaths = global.save.deaths_A;
    
    if (_deaths <= 30)
        scr_get_achievement("WIN_DEATH_30");
    
    if (_deaths <= 15)
        scr_get_achievement("WIN_DEATH_15");
    
    if (_deaths <= 5)
        scr_get_achievement("WIN_DEATH_5");
    
    if (_deaths == 0)
        scr_get_achievement("WIN_DEATH_0");
    
    if (!global.save.campaign_beat_A)
        first_beat = true;
    else
        first_beat = false;
    
    variable_struct_set(global.save, $"campaign_beat_{_side}", true);
    variable_struct_set(global.save, $"last_room_{_side}", -4);
    variable_struct_set(global.save, $"dollars_{_side}", 0);
    variable_struct_set(global.save, $"deaths_{_side}", 0);
    
    with (obj_persistent)
        event_save();
}

new_highscore = true;
done = false;
scroll_x = 0;
scroll_y = 0;

if (room == rm_title)
    bgm_play = noone;
else
    bgm_play = audio_play_sound(bgm_results, 0, true);

my_score = [global.last_highscore_name, global.dollars, "new"];
highscores = get_highscore();

if (my_score[1] < highscores[9][1])
{
    new_highscore = false;
    done = true;
    highscores[10] = my_score;
}
else
{
    array_push(highscores, my_score);
    
    var _sort = function(arg0, arg1)
    {
        return sign(arg1[1] - arg0[1]);
    };
    
    array_sort(highscores, _sort);
}

initial_index = 0;
initials_list = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "!"];
flash_delay = 0;
timer[0] = 15;

timer_func[0] = function()
{
    if (room == rm_results)
    {
        if (new_highscore)
        {
            voice_play = audio_play_sound(voice_announcer_newhighscore, 0, false);
        }
        else
        {
            var _voice = choose(voice_announcer_stageclear10, voice_announcer_stageclear9, voice_announcer_stageclear7);
            voice_play = audio_play_sound(_voice, 0, false);
        }
    }
};

voice_play = noone;
