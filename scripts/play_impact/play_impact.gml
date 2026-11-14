function play_impact()
{
    audio_play_sound(asset_get_index($"snd_impact{irandom_range(0, 6)}"), 0, 0);
}
