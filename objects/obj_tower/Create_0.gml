hit_wait = -1;

if (!array_contains(global.stages_final_scroll, room))
{
    x = 0;
    y = 0;
}

hits = 0;
y_sink = 0;
shake = 0;
var _to = 0;
var _percent = 1;
y_sink_start = _to * _percent;
timer[0] = -1;

timer_func[0] = function()
{
    shake = 1;
    var _sep = 110;
    var _x = x + irandom_range(-_sep, _sep);
    var _y = y + y_sink + irandom_range(50, 650);
    var _fx = instance_create_layer(_x, _y, layer, obj_fx_explosion);
    _fx.bg = true;
    screen_shake(6.5, 6.5, 0.5);
    var _snd = audio_stop_play(snd_explosion, 0, 0);
    audio_sound_gain(_snd, 0.6, 0);
    timer[0] = 15;
};

sink = false;
