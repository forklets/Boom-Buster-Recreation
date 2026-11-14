event_inherited();
powerup = noone;

event_cash = function()
{
    cash = true;
    audio_play_sound(snd_shield, 0, 0);
    timer[2] = 21;
    vspd = -12;
    grav = 0.95;
};

float_anim = false;
time = 0;
