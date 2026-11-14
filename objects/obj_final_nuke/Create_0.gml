anim_init();
anim_play(spr_final_nuke_buster);
y = obj_cam_final_maxY.y - 10;
vspd = 0;
timer[0] = -1;

timer_func[0] = function()
{
    audio_play_sound(voice_wizard_screamno, 0, false);
    
    with (obj_wizard_final)
        anim_play(spr_wizard_final_noo);
};

timer[1] = -1;

timer_func[1] = function()
{
    with (obj_wizard_final)
    {
        anim_play(spr_wizard_final_ohgod);
        anim_speed = 1;
    }
};
