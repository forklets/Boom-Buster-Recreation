physics_init();
anim_init();

event_animend = function()
{
    var _spr = anim_sprite;
    
    if (_spr == spr_scarab_flip)
    {
        timer[0] = 30;
        anim_play(spr_scarab_bomb);
    }
};

timer[0] = -1;

timer_func[0] = function()
{
    state = 1;
    timer[1] = 30;
    anim_sprite = spr_scarab_bomb_edge;
};

timer[1] = -1;

timer_func[1] = function()
{
    var _inst = instance_create_layer(x, y - 32, "Particles_Over", obj_explosion_hurt);
    screen_shake(7, 7);
    audio_play_sound(snd_explosion, 0, false);
    instance_destroy();
};

state = 0;
