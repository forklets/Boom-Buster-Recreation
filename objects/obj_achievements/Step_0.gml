var _char = global.player_character[0];
bg_pos += 0.5;
buster_ind += (sprite_get_speed(buster_spr) / 60);
bridget_ind += (sprite_get_speed(bridget_spr) / 60);

if (buster_ind >= (sprite_get_number(buster_spr) - 1))
    event_animend_buster();

if (bridget_ind >= (sprite_get_number(bridget_spr) - 1))
    event_animend_bridget();

if ((input_check_pressed_all("spin") || input_check_pressed_all("back")) && !deac)
{
    input_verb_consume_all("spin");
    input_verb_consume_all("back");
    deac = true;
    instance_destroy();
}

effect_alpha -= 0.07500000000000001;
effect_scale += 0.015;
timer_logic(0);

if (deac)
    exit;

var _yAxis = input_check_pressed_all("down") - input_check_pressed_all("up");
selected += _yAxis;
var _max = array_length(pals) - 1;

if (selected < 0)
    selected = _max;

if (selected > _max)
    selected = 0;

var _pals;

if (global.player_character[0] == 0)
    _pals = pals_bu;
else
    _pals = pals_br;

var _got = check_unlocked(_pals, selected)[0];

if (input_check_pressed_all("jump"))
{
    if (_got)
    {
        global.palette[_char] = selected;
        var _snd = audio_play_sound(snd_kaching, 0, false);
        audio_sound_pitch(_snd, 1.1);
        effect_alpha = 1;
        effect_scale = 1;
    }
    else
    {
        audio_stop_play(snd_wrong, 0, false);
    }
}

if (room == rm_title && global.save.campaign_beat_A && input_check_pressed_all(global.input_menu_special))
{
    global.player_character[0] = !global.player_character[0];
    selected = global.palette[global.player_character[0]];
}

set_menu_yoff();
