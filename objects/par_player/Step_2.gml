if (instance_exists(obj_round_clear_select))
    exit;

if (state == state_cannon && !cannon_shot)
{
    x = my_cannon.x;
    y = my_cannon.y;
}

if (global.auto_scroller && !obj_editor.edit_mode)
{
    get_cams(0);
    
    if (x < (camx - 192))
    {
        global.bubble = false;
        invulnerable = false;
        event_user(0);
    }
    
    if (x > (camx + camw))
    {
        x = camx + camw;
        hspd = 0;
    }
}

if (keyboard_check_pressed(ord("T")) && global.debug)
    squish_percent = 0;

if (squish == squish_land)
{
    var _curve = acurv_player;
    var _channel = "elastic";
    squish_percent = approach(squish_percent, 1, 1/30);
    xscale_squish = use_curve(_curve, squish_percent, _channel, 1.5, 1);
    yscale_squish = use_curve(_curve, squish_percent, _channel, 0.5, 1);
}
else if (squish == squish_jump)
{
    var _curve = acurv_player;
    var _channel = "elastic";
    squish_percent = approach(squish_percent, 1, 0.03571428571428571);
    xscale_squish = use_curve(_curve, squish_percent, _channel, 0.5, 1);
    yscale_squish = use_curve(_curve, squish_percent, _channel, 1.5, 1);
}
else if (squish == squish_crouch)
{
    var _curve = acurv_player;
    var _channel = "elastic";
    squish_percent = approach(squish_percent, 1, 0.03571428571428571);
    xscale_squish = use_curve(_curve, squish_percent, _channel, 0.5, 1);
    yscale_squish = use_curve(_curve, squish_percent, _channel, 1.5, 1);
}
else if (squish == squish_slide)
{
    var _curve = acurv_player;
    var _channel = "elastic";
    squish_percent = approach(squish_percent, 1, 0.05);
    xscale_squish = use_curve(_curve, squish_percent, _channel, 1.4, 1);
    yscale_squish = use_curve(_curve, squish_percent, _channel, 0.6, 1);
}
else if (squish == squish_skid)
{
    var _curve = acurv_player;
    var _channel = "elastic";
    squish_percent = approach(squish_percent, 1, 0.05);
    xscale_squish = use_curve(_curve, squish_percent, _channel, 1.2, 1);
    yscale_squish = use_curve(_curve, squish_percent, _channel, 0.8, 1);
}
