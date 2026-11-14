function audio_play_sound_delay(arg0, arg1, arg2 = 1)
{
    var _snd = instance_create_layer(0, 0, layer, obj_sound_delay);
    _snd.snd = arg0;
    _snd.timer[0] = arg1;
    _snd.gain = arg2;
}
