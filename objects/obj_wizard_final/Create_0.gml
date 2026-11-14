voice_play_ow = noone;
ow_index = 0;
voices_ow = [voice_wizard_pain0, voice_wizard_pain1, voice_wizard_pain2, voice_wizard_pain3, voice_wizard_pain4, voice_wizard_pain5, voice_wizard_pain6, voice_wizard_pain1, voice_wizard_pain3, voice_wizard_pain2, voice_wizard_pain4, voice_wizard_pain6, voice_wizard_pain5];
voice_wait = 0;
anim_init();
timer[0] = -1;

timer_func[0] = function()
{
    var _state = state;
    
    if (_state == 0)
    {
        anim_play(spr_wizard_final_look);
        
        with (obj_controller)
        {
            wizard_sprite = spr_tv_wizard_huh_turn;
            wizard_sub = 0;
        }
        
        audio_play_sound(voice_wizard_wait_shit, 0, false);
        state = 1;
        timer[0] = 50;
    }
    else if (_state == 1)
    {
        prompt = true;
        
        with (obj_player)
        {
            deac_allow_spin = true;
            throw_fast = true;
        }
    }
};

event_animend = function()
{
    var _spr = anim_sprite;
    
    if (_spr == spr_wizard_final_look)
    {
        anim_play(spr_wizard_final_look_boil);
        
        with (obj_controller)
        {
            wizard_sprite = spr_tv_wizard_huh_turn_boil;
            wizard_sub = 0;
        }
    }
};

timer[1] = -1;

timer_func[1] = function()
{
    hits_last = true;
};

hits_last = false;
timer[2] = -1;

timer_func[2] = function()
{
    with (obj_final_nuke)
        event_user(0);
};

state = 0;
prompt = false;
prompt_alpha = 0;
prompt_ind = 0;
prompt_swap_delay_count = 10;
prompt_swap_delay = prompt_swap_delay_count;
hit_count = 0;
