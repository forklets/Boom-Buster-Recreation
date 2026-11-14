anim_play(spr_landmine_exploded);
var _strength = 50;
screen_shake(_strength, _strength, 0.9846153846153847);
audio_play_sound(snd_explosion, 0, false);

with (obj_player)
{
    hurt_by = other.id;
    event_user(0);
}

var _fx = instance_create_layer(x + 32, y, "Particles_Over", obj_fx_explosion);

with (_fx)
{
}

exploded = true;
