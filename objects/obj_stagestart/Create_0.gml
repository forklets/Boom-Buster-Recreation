texture_prefetch("game_main");
global.freeze = 99999;
fade_alpha = 1;
state = 0;
surf = surface_create(1920, 1080);
radius = 0;
radius_add = 0;
spd = 0.3;
skipped = false;

if (obj_controller.stage_event == "wizard" && room != global.last_room && room != rm_outskirts_2 && room != rm_outskirts_3 && room != rm_outskirts_b2 && room != rm_outskirts_b3)
    boss_cutscene = true;
else
    boss_cutscene = false;

timer[0] = 45;

timer_func[0] = function()
{
    state++;
    
    if (state == 1)
    {
        if (boss_cutscene)
            timer[1] = 30;
        else
            timer[0] = 80;
        
        with (par_player)
        {
            state = state_intro;
            anim_play(player_taunt);
        }
    }
};

timer[1] = -1;

timer_func[1] = function()
{
    audio_stop_sound(global.bgmPlay);
    var _fake = instance_create_layer(0, 0, layer, obj_stagestart_boss);
    _fake.radius = radius;
    
    with (par_player)
        anim_play(player_confused);
    
    instance_destroy();
};

if (global.acts == 1 || obj_controller.stage_event == "wizard")
    display_act = false;
else
    display_act = true;

display_act = true;
