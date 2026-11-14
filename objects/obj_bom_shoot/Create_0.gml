anim_init();
tower_offset = irandom_range(50, 350);
vspd = -20;

event_explode = function()
{
    with (obj_tower)
        event_user(0);
    
    var _fx = instance_create_layer(x, y, layer, obj_fx_explosion);
    _fx.bg = true;
    
    if (!obj_wizardevent_win.lose_hp)
    {
        global.boss_hp--;
        obj_wizardevent_win.lose_hp = true;
    }
    
    obj_controller.wizard_flash = 1.4;
    obj_controller.wizard_sprite = spr_tv_wizard_ouch;
    
    if (instance_exists(obj_tower))
        obj_controller.timer[obj_controller.timer_clear] = 150;
    else
        obj_controller.timer[obj_controller.timer_win] = 150;
    
    screen_shake(26, 26, 0.5);
    audio_stop_play(snd_explosion, 0, 0);
    instance_destroy();
};
