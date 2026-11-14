anim_init();
triggered = false;
exploded = false;
timer[0] = -1;

timer_func[0] = function()
{
    audio_pause_all();
    
    if (audio_is_playing(global.bgmPlay))
        audio_resume_sound(global.bgmPlay);
    
    global.freeze = 15;
    
    global.freeze_func = function()
    {
        with (obj_landmine)
        {
            if (triggered)
                event_user(0);
        }
    };
    
    ds_list_add(global.list_ignorefreeze, id);
    anim_play(spr_landmine_trigger);
};

depth = layer_get_depth(layer_get_id("Instances_Over")) - 10;
