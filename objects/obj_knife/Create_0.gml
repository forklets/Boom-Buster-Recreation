anim_init();
vspd = 28;
image_xscale = 1.2;
image_yscale = 1.2;
audio_stop_play(snd_knife_swish, 0, false);
timer[0] = 3;

timer_func[0] = function()
{
    timer[0] = 3;
    var _fx = instance_create_layer(x, y, "Particles_Behind", obj_fx);
    _fx.image_alpha = 0.6;
    _fx.image_alpha_to = 0;
    _fx.destroy = 1;
    _fx.anim_sprite = anim_sprite;
    _fx.anim_index = anim_index;
    _fx.anim_speed = 0;
    _fx.bm = 1;
};
