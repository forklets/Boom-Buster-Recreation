var _snd = audio_play_sound(snd_explosion, 0, false);
audio_sound_gain(_snd, 2.5, 0);
instance_create_layer(0, 0, "Transition", obj_final_blow);
timer[0] = 10;
