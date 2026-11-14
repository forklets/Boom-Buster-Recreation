percent_scale = 0;
percent_yoff = 0;
yoff = 0;
audio_play_sound(snd_cannon_shoot, 0, 0);
var _off = -48;
var _x = x;
var _y = y;

if (image_angle == 0)
    _y += _off;
else if (image_angle == 180)
    _y -= _off;
else if (image_angle == 90)
    _x += _off;
else if (image_angle == 270)
    _x -= _off;

part_particles_create(global.part_over, _x, _y, global.particles.smoke, 1);
