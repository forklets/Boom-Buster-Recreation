if (!ready)
    exit;

get_cams(0);

if (!((y + 200) >= camy))
    exit;

if (!played)
{
    var _snd = audio_stop_play(snd_explosion, 0, false);
    audio_sound_gain(_snd, 2, 0);
    played = true;
}

anim_logic();
