if (exit_freeze())
    exit;

if (!place_meeting(x, y + 48, par_ground) && room == rm_bonus_b3)
    instance_destroy();

var _player = instance_place(x, y, obj_player);

if (_player && !triggered)
{
    audio_play_sound(snd_wrongbuzzer, 0, false);
    triggered = true;
    anim_play(spr_landmine_trigger);
}

if (triggered && !_player && !exploded)
    event_user(0);

timer_logic(0);
anim_logic();
