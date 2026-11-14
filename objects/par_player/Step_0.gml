if (instance_exists(obj_round_clear_select))
    exit;

var _input = (global.players > 1) ? input_check : input_check_all;
var _input_pressed = (global.players > 1) ? input_check_pressed : input_check_pressed_all;

if (action != action_free || state != state_free)
    skidding = false;

if (!skidding || exit_freeze())
{
    if (audio_is_playing(skidSnd))
        audio_stop_sound(skidSnd);
}

timer_func[timer_rundust] = function()
{
    if (dust_run)
    {
        var _dust = instance_create_layer(x - (10 * facing), y, "Particles_Over", obj_fx_dust);
        _dust.hspd = -facing * 3;
        var _scale = 1.3;
        _dust.image_xscale = _scale;
        _dust.image_yscale = _scale;
    }
};

set_palette();

if (obj_controller.win || state == state_deac || deac_controls || (state == state_free && action == action_dazed))
{
    input_verb_consume("left", player);
    input_verb_consume("right", player);
    input_verb_consume("up", player);
    input_verb_consume("down", player);
    input_verb_consume("jump", player);
    
    if (!deac_allow_spin)
        input_verb_consume("spin", player);
    
    input_verb_consume("dash", player);
    input_verb_consume("special", player);
    input_verb_consume("crouch", player);
    input_verb_consume("start", player);
}

if (keyboard_check_pressed(vk_tab) && global.debug)
{
    recording = !recording;
    
    if (recording)
    {
        record_frames = [];
    }
    else
    {
        var _str = json_stringify(record_frames, true);
        var _open = file_text_open_write(get_save_filename("*.json", ""));
        file_text_write_string(_open, _str);
        file_text_close(_open);
    }
}

if (recording)
{
    array_push(record_frames, 
    {
        x: x,
        y: y,
        spr: sprite_get_name(anim_sprite),
        ind: anim_index,
        facing: facing,
        xscale_squish: xscale_squish,
        yscale_squish: yscale_squish
    });
}

var _cannon_func = function(arg0)
{
    ignore_cannon = arg0;
    cannon_shot = false;
    obj_controller.relative_pos_ease = 0;
    my_cannon = arg0;
    x = my_cannon.x + 8;
    y = my_cannon.y;
    
    if (my_cannon.deac_player)
        deac_controls = true;
    
    state = state_cannon;
    reset_action();
    coyote_spin = 0;
    coyote_slide = 0;
};

if (place_meeting(x, y, obj_cannon))
{
    var _cannon = instance_place(x, y, obj_cannon);
    
    if (_cannon && ignore_cannon != _cannon)
    {
        if (array_contains(global.stages_final, room))
        {
            with (obj_player)
                _cannon_func(_cannon);
            
            with (obj_player2)
            {
                ignore_cannon = _cannon;
                cannon_shot = false;
                obj_controller.relative_pos_ease = 0;
                my_cannon = _cannon;
                x = my_cannon.x + 8;
                y = my_cannon.y;
                
                if (my_cannon.deac_player)
                    deac_controls = true;
                
                state = state_cannon;
                reset_action();
                coyote_spin = 0;
                coyote_slide = 0;
            }
        }
        else
        {
            _cannon_func(_cannon);
        }
        
        with (_cannon)
            event_user(0);
    }
}

if (global.stage_type == 1)
{
    if (auto_facing == 1)
        xAxis = 1;
    else if (auto_facing == -1)
        xAxis = -1;
}

if (global.stage_type != 1)
{
    crouch_input = (global.crouch_down && _input("down", player)) || _input("crouch", player);
    crouch_input_pressed = (global.crouch_down && _input_pressed("down", player)) || _input_pressed("crouch", player);
}

switch (state)
{
    case state_free:
        scr_player_state_free();
        break;
    
    case state_hurt:
        scr_player_state_hurt();
        break;
    
    case state_powerup:
        if (anim_index >= powerup_index_change[newPowerup])
        {
            if (!transformed)
            {
                flash_white = true;
                flash_white_alpha = 0.5;
                flash_white_percent = 0.5;
                transformed = true;
            }
            
            if (newPowerup == 2)
            {
                global.invincible = true;
                
                if (!audio_is_playing(mySnd_nuclear))
                    mySnd_nuclear = audio_play_sound(snd_nuclear, 0, true);
            }
            else
            {
                global.powerup = newPowerup;
            }
        }
        
        global.freeze = 999999;
        anim_logic();
        break;
    
    case state_deac:
        if (exit_freeze())
            exit;
        
        timer_logic(timer_pit);
        break;
    
    case state_intro:
        anim_logic();
        break;
    
    case state_cannon:
        if (exit_freeze())
            exit;
        
        anim_logic();
        timer_logic(timer_invulnerable_flash);
        timer_logic(timer_become_vulnerable);
        
        var _rotate_cannon = function()
        {
            var _angle = cannon_angle;
            var _spd = cannon_bounce_height * 3.25;
            hspd = dsin(_angle + 180) * _spd;
            vspd = dcos(_angle + 180) * _spd;
            show_debug_message($"hspd:{hspd}\nvspd:{vspd}");
        };
        
        if (cannon_free && cannon_shot)
        {
            xAxis = _input("right", player) - _input("left", player);
            hspd = approach(hspd, xAxis * 9, 1);
        }
        
        if (!cannon_shot)
        {
            if (char == 0)
                anim_play(spr_buster_cannon);
            else
                anim_play(spr_bridget_cannon);
            
            if (_input_pressed("jump", player) || my_cannon.auto || (input_check_pressed_all("jump") && array_contains(global.stages_final, room)))
            {
                if (my_cannon.target_height != noone)
                    bounce_blocks = max(abs((my_cannon.target_height - y) / 64), 4.2);
                else
                    bounce_blocks = my_cannon.bounce_height;
                
                cannon_angle = my_cannon.image_angle;
                cannon_bounce_height = my_cannon.bounce_height;
                
                if (cannon_angle == 0)
                    vspd = -calculate_jump(bounce_blocks, grav_normal);
                else
                    _rotate_cannon();
                
                cannon_shot = true;
                
                if (char == 0)
                    anim_play(spr_buster_cannonshoot);
                else
                    anim_play(spr_bridget_cannonshoot);
                
                anim_index = 3;
                aframe_delay = 0;
                
                with (my_cannon)
                    event_user(1);
                
                if (my_cannon.free)
                    cannon_free = true;
                else
                    cannon_free = false;
                
                my_cannon = noone;
            }
        }
        else
        {
            if (aframe_delay == 0)
            {
                var _fx = instance_create_layer(x, y, "Particles_Behind", obj_player_aframe);
                _fx.image_alpha = 0.7;
                _fx.image_alpha_to = 0;
                _fx.destroy = 1;
                _fx.anim_sprite = anim_sprite;
                _fx.anim_index = anim_index;
                _fx.image_xscale = facing;
                _fx.pal_sprite = pal_sprite;
                _fx.pal_ind = other.myPal;
                _fx.anim_speed = 0;
                _fx.bm = 1;
                var _life = 10;
                _fx.image_alpha_spd = (_fx.image_alpha - _fx.image_alpha_to) / _life;
                aframe_delay = 2;
            }
            
            if (aframe_delay)
                aframe_delay--;
            
            var _rotated = false;
            
            if (cannon_angle != 0)
            {
                _rotate_cannon();
                _rotated = true;
            }
            
            if (!exit_freeze())
            {
                if (cannon_angle != 0)
                {
                    var _grav = grav;
                    grav = 0;
                    physics_apply();
                    grav = _grav;
                }
                else
                {
                    physics_apply();
                }
            }
            
            if (instance_exists(ignore_cannon))
            {
                if (((ignore_cannon.image_angle == 0 && vspd >= -2) || (ignore_cannon.image_angle == 270 && hspd <= 2) || (ignore_cannon.image_angle == 90 && hspd >= -2)) && !cannon_free)
                {
                    cannon_shot = true;
                    ignore_cannon = noone;
                    state = state_free;
                    aframe_delay = -1;
                }
            }
            
            if (instance_exists(ignore_cannon) && cannon_free && !place_meeting(x, y, ignore_cannon))
                ignore_cannon = noone;
            
            if (cannon_free && _input_pressed("dash"))
            {
                state = state_free;
                action = action_free;
                scr_player_state_free();
            }
            
            if (ignore_cannon == noone && place_meeting(x, y, obj_cannon))
                state = state_free;
        }
        
        break;
    
    case state_hurt_coop:
        anim_logic();
        timer_logic(timer_leave_hurt);
        break;
    
    case state_mud:
        x += hspd;
        y += vspd;
        visible = false;
        
        if (!place_meeting(x, y, obj_mud))
        {
            state = state_free;
            hspd = mud_dir[0] * mud_spd_out;
            vspd = mud_dir[1] * mud_spd_out;
            visible = true;
        }
        
        break;
}

if (exit_freeze())
    exit;

if (flash_white)
{
    flash_white_percent = approach(flash_white_percent, 1, 0.06);
    flash_white_alpha = sin(flash_white_percent * pi);
    
    if (flash_white_percent == 1)
    {
        flash_white_percent = 0;
        flash_white_alpha = 0;
        flash_white = false;
    }
}

hspd_bounce = approach(hspd_bounce, 0, 0.5);
timer_logic(timer_meterflash);

if (global.invincible)
{
    if (global.combo_meter <= 5)
    {
        if (timer[timer_meterflash] == -1)
        {
            if (global.combo_meter <= 1.5)
                timer[timer_meterflash] = 4;
            else
                timer[timer_meterflash] = 7;
        }
    }
    
    if (!audio_is_playing(mySnd_nuclear))
        mySnd_nuclear = audio_play_sound(snd_nuclear, 0, true);
    
    var _seconds = 12;
    global.combo_meter = approach(global.combo_meter, 0, global.combo_meter_max / (_seconds * 60));
    
    if (global.combo_meter == 0)
    {
        global.invincible = false;
        audio_play_sound(snd_losepowerup, 0, 0);
    }
}
else if (audio_is_playing(mySnd_nuclear))
{
    audio_stop_sound(mySnd_nuclear);
    audio_play_sound(snd_nuclear_end, 0, 0);
}

if (global.invincible && place_meeting(x, y, par_enemy))
{
    var _inst = instance_place(x, y, par_enemy);
    
    with (_inst)
    {
        if (!invincible)
        {
            hitBy = other.id;
            event_user(1);
        }
    }
}

var _hurt = instance_place(x, y, par_hurt);

if (_hurt)
{
    hurt_by = _hurt;
    event_user(0);
}

_hurt = instance_place(x, y, par_hurt_insta);

if (_hurt)
{
    invulnerable = false;
    global.bubble = false;
    global.powerup = 0;
    hurt_by = _hurt;
    event_user(0);
}

if (keyboard_check_pressed(ord("N")) && global.debug)
    global.combo_meter += 5;

if (state == state_free || state == state_cannon)
{
    if (global.combo_meter == global.combo_meter_max)
    {
        if (_input_pressed("special"))
        {
            var _inst = instance_create_layer(x, y, layer, obj_dynalife);
            _inst.visible = false;
            global.combo_meter = 0;
            
            with (obj_tutorial_text)
                timer[0] = 60;
        }
    }
    
    event_user(3);
}
