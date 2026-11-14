var _score = 0 + (1 * combo) + bonus_score;
pipe_yoff_percent = 0;
combo++;
combo_timer = 8;
comboScore += _score;
bonus_score = 0;

if (instance_exists(myScoreFX))
    instance_destroy(myScoreFX);

if (comboScore != 0)
    myScoreFX = score_spawn(x + 128, y, comboScore, undefined, false);

score_add(_score);
audio_stop_play(snd_kaching, 0, 0);
audio_stop_play(snd_thunk, 0, 0);
anim_sprite = spr_pipe_enter;
anim_index = 0;

if (combo >= 2)
{
    if (!instance_exists(lastCombo))
        lastCombo = instance_create_layer(x + 128, y - 80, "GUI", obj_fx_combo);
    
    lastCombo.combo = combo;
    
    with (lastCombo)
        event_user(0);
    
    combo_play_sound();
}
