image_speed = 0;
shattered = false;

event_shatter = function()
{
    image_index = 1;
    shattered = true;
    audio_play_sound(snd_glass_shatter, 0, false);
    var _coin = instance_create_layer(x + 64, y + 128, "Instances", obj_coin);
    
    with (_coin)
    {
        worth = 1;
        event_user(0);
    }
    
    var _num = sprite_get_number(spr_wiz_glass_shards) - 2;
    
    for (var i = 0; i < _num; i++)
    {
        var _x = x + 64 + irandom_range(-55, 55);
        var _y = y + 128 + irandom_range(-118, 118);
        var _fx = instance_create_layer(_x, _y, "Particles_Over", obj_fx);
        _fx.anim_sprite = spr_wiz_glass_shards;
        _fx.anim_index = i;
        _fx.image_angle = irandom_range(0, -359);
        var _hspd = random_range(-6, 6);
        var _vspd = random_range(-9, -13);
        var _grav = 0.65;
        _fx.rot_spd = -_hspd;
        _fx.hspd = _hspd;
        _fx.vspd = _vspd;
        _fx.grav = _grav;
        var _scale = random_range(1, 1.25);
        _fx.image_xscale = _scale;
        _fx.image_yscale = _scale;
    }
};
