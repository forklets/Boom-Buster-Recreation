event_inherited();

with (obj_pipe)
{
    if (col == other.col)
        other.my_pipe = id;
}

var _snd = audio_stop_play(snd_coin, 0, false);
audio_sound_pitch(_snd, 0.9);
var _x = my_pipe.x + 128;
var _y = my_pipe.y;
var _rotoffset = irandom_range(0, 360);
star_count = 7;

for (var i = 0; i < star_count; i++)
{
    var _angle = ((360 / star_count) * i) + _rotoffset;
    var _part = part_type_create();
    part_type_sprite_simple(_part, spr_fx_sparkle_yellow);
    part_type_direction(_part, _angle, _angle, 0.5, 0);
    part_type_speed(_part, 3, 3, -0.12, 0);
    part_particles_create(global.part_over, _x, _y, _part, 1);
    ds_map_add(global.map_particles, _part, 120);
}

part_particles_create(global.part_over, _x, _y, global.particles.ring, 1);
