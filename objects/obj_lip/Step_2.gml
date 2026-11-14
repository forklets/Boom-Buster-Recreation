event_inherited();

if (room == rm_round_5 && place_meeting(x, y + 1, obj_movingsemi) && y > (room_height - 256) && !falling_scream)
{
    var _snd = audio_play_sound(voice_buster_scream2, 0, false);
    audio_sound_pitch(_snd, 0.725);
    audio_sound_gain(_snd, 0, 600);
    anim_play(spr_lip_spun);
    falling_scream = true;
    falling_scream_facing = facing;
}

if (falling_scream)
    facing = falling_scream_facing;
