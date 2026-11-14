fire = false;
lava = false;
anim_init();
loops = 0;

event_animend = function()
{
    loops++;
    
    if (loops == 4)
    {
        if (char == 0)
            anim_play(spr_buster_death_zap_crisp);
        else
            anim_play(spr_bridget_death_zap_crisp);
        
        if (audio_is_playing(voice_buster_scream_0))
            audio_stop_sound(voice_buster_scream_0);
        
        if (audio_is_playing(voice_buster_scream_1))
            audio_stop_sound(voice_buster_scream_1);
        
        if (audio_is_playing(voice_bridget_scream_0))
            audio_stop_sound(voice_bridget_scream_0);
        
        if (audio_is_playing(voice_bridget_scream_1))
            audio_stop_sound(voice_bridget_scream_1);
        
        if (audio_is_playing(snd_flame))
            audio_stop_sound(snd_flame);
        
        audio_stop_play(snd_sizzle, 0, false);
        create_smoke = true;
        timer_func[0]();
        
        with (lightning)
        {
            if (object_index != obj_lava)
                instance_destroy();
        }
    }
};

facing = 1;
timer[0] = -1;

timer_func[0] = function()
{
    for (var i = 0; i < choose(1, 2); i++)
    {
        var _layer = choose("Particles_Over", "Particles_Behind");
        var _x = x + irandom_range(-35, 35);
        var _y = y + irandom_range(-110, -24);
        var _fx = instance_create_layer(_x, _y, _layer, obj_fx_dust);
        _fx.anim_sprite = spr_fx_burnt_smoke;
        _fx.hspd = 0;
        _fx.vspd = random_range(-3, -5);
    }
    
    timer[0] = 7;
};

create_smoke = false;
