with (obj_persistent)
    event_save();

texture_prefetch("tg_cutscene_ending");
anim_init();
anim_play(spr_cutscene_ending_players_start);
ending_index = 0;
bg_sprite = spr_cutscene_ending_bg;
smoke_ind = 0;
delay = 219;
timer[0] = delay;

timer_func[0] = function()
{
    ending_index++;
    timer[1] = delay;
    bg_sprite = spr_cutscene_ending_players_bg;
    anim_sprite = spr_cutscene_ending_players;
};

sprite_set_speed(spr_cutscene_ending_players, 1.5, 0);
timer[1] = -1;

timer_func[1] = function()
{
    out = true;
};

out = false;
fade = 0;
tower_sink = 0;
bgm_play = audio_play_sound(bgm_opening, 0, true);
