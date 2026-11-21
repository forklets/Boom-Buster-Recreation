function init_game_globals()
{
    audio_sound_gain(snd_explosion, 1 * global.master_vol * global.sfx_vol, 1500);

    with (obj_persistent)
    {
        shake_strength[0] = 0;
        shake_strength[1] = 0;
    }

    global.deaths = 0;
    global.died = false;
    global.next_room = rm_title;
    global.tutorial_trigger = 0;
    global.playground = false;
    global.auto_scroller = false;
    global.hpmax = 1;
    global.hp = global.hpmax;
    global.powerup = 0;
    global.bubble = false;
    global.dollars = 0;
    global.dollars_start = global.dollars;
    global.top_dollars = 0;
    global.combo_meter = 0;
    global.combo_meter_max = 170;
    global.invincible = false;
    global.orb_round = 0;
    global.freeze = 0;

    for (var i = 0; i < 3; i++)
        global.food[i] = false;

    global.goodnight = false;
    global.dome = false;
    global.dome_alpha = 0;
    global.dome_ind = -1;
    global.dome_timer = 300;
    global.dome_order = [];

    for (var i = 0; i < sprite_get_number(bgr_city_sunset_dome); i++)
        global.dome_order[i] = i;

    global.dome_order = array_shuffle(global.dome_order);
    global.blood = [];
}
