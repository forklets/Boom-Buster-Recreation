if (exit_freeze())
    exit;

anim_logic();

if (global.orb_round != coin_round)
    exit;

with (par_player)
{
    mask_before = mask_index;
    mask_index = spr_mask_player;
}

var _inst = instance_place(x, y, par_player);

if (_inst && !collected)
{
    var _snd = audio_stop_play(snd_nab, 0, false);
    audio_sound_pitch(_snd, 2);
    audio_sound_gain(_snd, 0.22, 0);
    collected = true;
    image_alpha = 0;
    event_collect(_inst);
    score_add(worth);
    var _exists = false;
    
    with (obj_coin_map)
    {
        if (coin_round == global.orb_round && !collected)
            _exists = true;
    }
    
    if (!_exists && !obj_controller.bridget_done)
    {
        global.orb_round++;
        
        if (global.orb_round > 2)
            global.orb_round = 0;
        
        with (obj_coin_map)
        {
            if (coin_round == global.orb_round)
            {
                collected = false;
                image_alpha = 1;
            }
            else
            {
                image_alpha = 0;
            }
        }
    }
}

with (par_player)
    mask_index = mask_before;
