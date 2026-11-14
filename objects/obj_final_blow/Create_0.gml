var _room;

if (global.bside)
{
    scr_get_achievement("THE_END_B");
    _room = "rm_final_scroll_b";
}
else
{
    scr_get_achievement("THE_END");
    _room = "rm_final_scroll";
}

if (!array_contains(global.save.stages_beat, _room))
    array_push(global.save.stages_beat, _room);

if (global.player_character[0] == 1)
    scr_get_achievement("WIZARD_BRIDGET");

fade_alpha = 0;
timer_delay = 10;
timer[0] = timer_delay;

timer_func[0] = function()
{
    var _x = irandom_range(-40, 1960);
    var _y = irandom_range(-40, 1120);
    var _fx = instance_create_layer(_x, _y, "Particles_Over", obj_fx);
    
    with (_fx)
    {
        var _col = irandom_range(0, 4);
        anim_play(global.explosions[_col]);
        gui = true;
    }
    
    audio_stop_play(snd_explosion, 0, false);
    timer[0] = timer_delay;
};

timer[1] = -1;

timer_func[1] = function()
{
    fade_black = true;
    audio_sound_gain(global.bgmPlay, 0, 2000);
};

timer[2] = -1;

timer_func[2] = function()
{
    if (global.round_select)
    {
        if (!instance_exists(obj_round_clear))
            instance_create_layer(0, 0, layer, obj_round_clear);
    }
    else
    {
        room_goto(rm_final_ending);
    }
};

fade_black = false;
fade_black_alpha = 0;
