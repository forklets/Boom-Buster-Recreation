if (collected)
    exit;

collected = true;
audio_stop_play(collect_sound, 0, 0);
vspd = -12;
grav = 0.95;
timer[2] = 28;

if (object_index == obj_coin)
    global.coins_collected++;
