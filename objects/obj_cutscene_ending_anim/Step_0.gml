anim_logic();
timer_logic(0);
timer_logic(1);

if (out)
{
    fade += 0.02;
    
    if (fade >= 3)
    {
        var _inst = instance_create_layer(0, 0, layer, obj_cutscene_ending);
        _inst.bgm_play = bgm_play;
        instance_destroy();
    }
}

tower_sink += 1;
smoke_ind += (sprite_get_speed(spr_cutscene_ending_smoke) / 60);
