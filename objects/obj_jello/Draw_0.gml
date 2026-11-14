if (onoff != noone)
{
    var _ind = global.onoff_colors[onoff] + 1;
    pal_swap(pal_onoff, global.colorblind, _ind);
}

draw_self();

if (onoff != noone)
    shader_reset();
