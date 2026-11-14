function scr_player_state_free()
{
    var _input_pressed = (global.players > 1) ? input_check_pressed : input_check_pressed_all;
    
    if (exit_freeze())
        exit;
    
    grounded = on_ground();
    var _action = action;
    var _backflip;
    
    if (char == 0)
        _backflip = spr_buster_backflip;
    else
        _backflip = spr_bridget_backflip;
    
    var mask_normal = spr_mask_player;
    var mask_crouch = spr_mask_playercrouch;
    var _walk = player_walk;
    var _skid = player_skid;
    var _walk_carry = player_walk_carry;
    var _skid_carry = player_skid_carry;
    var _dash, _slide, _crouch, _idle, _crouchwalk, _djump, _jump_bounce, _jump;
    
    if (ds_list_size(list_carry) == 0)
    {
        var _line_list = ds_list_create();
        collision_line_list(x, y + 1, x, y + 192, par_ground, true, true, _line_list, true);
        
        for (var i = 0; i < ds_list_size(_line_list); i++)
        {
            if (ds_list_find_value(_line_list, i).object_index == obj_pipe)
                ds_list_delete(_line_list, i);
        }
        
        if (!solid_meeting(x, y + 1, obj_conveyor_semi) && ds_list_size(_line_list) == 0)
            var _ledge = true;
        else
            var _ledge = false;
        
        ds_list_clear(_line_list);
        _idle = player_idle;
        _jump = player_jump;
        _djump = player_djump;
        _dash = player_dash;
        _slide = player_slide;
        _crouch = player_crouch;
        var _crouchin = spr_buster_crouchin;
        var _crouchout = spr_buster_crouchout;
        _crouchwalk = player_crouchwalk;
        _jump_bounce = player_bounce;
        
        if (global.throw_boms)
        {
            if (global.player_character[player] == 0)
            {
                _idle = spr_buster_idle_goggles;
                _walk = spr_buster_walk_goggles;
                _skid = spr_buster_skid_goggles;
                _jump = spr_buster_jump_goggles;
                _dash = spr_buster_dash_goggles;
                _djump = spr_buster_doublejump_goggles;
                _slide = spr_buster_slide_goggles;
                _crouch = spr_buster_crouch_goggles;
                _crouchwalk = spr_buster_crouchwalk_goggles;
                _backflip = spr_buster_backflip_goggles;
                _jump_bounce = spr_buster_spring_goggles;
            }
            else
            {
                _idle = spr_bridget_idle_goggles;
                _walk = spr_bridget_walk_goggles;
                _skid = spr_bridget_skid_goggles;
                _jump = spr_bridget_jump_goggles;
                _djump = spr_bridget_doublejump_goggles;
                _dash = spr_bridget_dash_goggles;
                _slide = spr_bridget_slide_goggles;
                _crouch = spr_bridget_crouch_goggles;
                _crouchwalk = spr_bridget_crouchwalk_goggles;
                _backflip = spr_bridget_backflip_goggles;
                _jump_bounce = spr_bridget_spring_goggles;
            }
        }
        
        if (cannon_shot)
        {
            if (char == 0)
                _jump = spr_buster_cannonshoot;
            else
                _jump = spr_bridget_cannonshoot;
        }
    }
    else
    {
        _idle = player_idle_carry;
        _jump = player_jump_carry;
        _djump = player_djump_carry;
        _dash = player_dash_carry;
        _slide = player_slide_carry;
        _crouch = player_crouch_carry;
        var _crouchin = spr_buster_crouchin_carry;
        var _crouchout = spr_buster_crouchout_carry;
        _crouchwalk = player_crouchwalk_carry;
        _jump_bounce = player_bounce;
        
        if (cannon_shot)
            _jump = spr_buster_cannonshoot;
    }
    
    if (instance_exists(obj_round_clear) && obj_round_clear.win_pose)
    {
        if (array_contains(global.stages_tutorial, room))
            _idle = player_win_tutorial;
        else
            _idle = player_win;
    }
    
    jump_max = 2;
    grav_normal = 1.5;
    grav_backflip = 1.9;
    grav_slam = 5;
    grav = grav_normal;
    jump_strength = calculate_jump(3.2, grav_normal);
    spinjump_strength = calculate_jump(1.35, grav_normal);
    backflip_strength = calculate_jump(5, grav_backflip);
    slam_strength = calculate_jump(5.1, grav_normal);
    vspd_max_normal = 32;
    vspd_max_slam = 40;
    vspd_max_hurt = 20;
    runspd = 10.75;
    crouchspd = 4;
    acc = 1.2;
    
    if (char == 1)
    {
        acc -= 0.25;
        runspd -= 0.35;
        jump_strength += 1.325;
        spinjump_strength += 1.375;
        backflip_strength += 0.85;
    }
    
    slidespd = runspd;
    slideboost = runspd + 3.5;
    dashspd = runspd + 3;
    mud_spd = 20;
    mud_spd_out = 8;
    can_crouch = true;
    slide_is_dash = false;
    horizontal_dash = true;
    vertical_dash = false;
    full_dash = false;
    can_spin = true;
    coyote_jump_time = 6;
    land_animation = false;
    skid_animation = true;
    dust_land = true;
    dust_run = true;
    var _runspd = runspd;
    var _crouchspd = crouchspd;
    var _acc = acc;
    var _possible = [0.65, 0.45];
    var _acc_skid = _possible[char];
    var _slidespd = slidespd;
    var _slideboost = slideboost;
    var _dashspd = dashspd;
    
    if (global.invincible)
    {
        _runspd = runspd_nuclear;
        _crouchspd = crouchspd_nuclear;
        _acc = acc_nuclear;
        _slidespd = slidespd_nuclear;
        _slideboost = slideboost_nuclear;
        _dashspd = dashspd_nuclear;
    }
    
    if (!can_crouch)
        crouch_input = false;
    
    var _jumped = false;
    
    if (land_anim_delay)
        land_anim_delay--;
    
    if ((action != action_free && !cannon_free) || on_ground())
        cannon_shot = false;
    
    timer_logic(timer_reset_action);
    timer_logic(timer_rundust);
    timer_logic(timer_invulnerable_flash);
    timer_logic(timer_become_vulnerable);
    
    if (aframe_delay > -1)
        aframe_delay--;
    
    if (aframe_delay == -1)
    {
        if (global.invincible)
            aframe_delay = 2;
        else if (action == action_spin)
            aframe_delay = 1;
        else if (action == action_dash)
            aframe_delay = 3;
    }
    
    if (action != action_spin && action != action_dash && !global.invincible)
        aframe_delay = -1;
    
    if (((hspd != 0 || vspd != 0) || global.invincible) && aframe_delay == 0)
    {
        var _fx = instance_create_layer(x, y, "Particles_Behind", obj_player_aframe);
        _fx.image_alpha = 0.6;
        _fx.image_alpha_to = 0;
        _fx.destroy = 1;
        _fx.anim_sprite = anim_sprite;
        _fx.anim_index = anim_index;
        _fx.image_xscale = facing;
        _fx.pal_sprite = pal_sprite;
        _fx.pal_ind = other.myPal;
        _fx.anim_speed = 0;
        
        if (global.invincible)
            _fx.bm = 1;
        
        var _life;
        
        if (action == action_dash)
            _life = 16;
        else
            _life = 10;
        
        _fx.image_alpha_spd = (_fx.image_alpha - _fx.image_alpha_to) / _life;
    }
    
    if (grounded)
        ground_reset_actions();
    
    solid_above = solid_meeting(x, y - 8, obj_solid);
    
    if ((action == action_crouch || action == action_crouch_spin) && !on_ground() && !solid_above)
    {
        _action = action;
        
        if (_action == action_crouch_spin)
            action = action_spin;
        else
            action = action_free;
    }
    
    if (!grounded)
        coyote_jump++;
    
    if (xAxisBefore == 0 && xAxis != 0 && can_dust())
        timer_func[timer_rundust]();
    
    var _grounded = grounded;
    
    if (xAxis != 0 && (_grounded || ds_list_size(list_carry) > 0) && action != action_backflip && action != action_spin && action != action_crouch_spin && action != action_dash && action != action_slide && anim_sprite != player_throw)
        facing = sign(xAxis);
    
    if (cannon_shot)
    {
        hspd = approach(hspd, 0, 0.5);
    }
    else if (action == action_dazed)
    {
        hspd = approach(hspd, 0, 0.5);
    }
    else if (action == action_slam)
    {
        hspd = 0;
    }
    else if (action == action_crouch || action == action_crouch_spin)
    {
        hspd = approach(hspd, xAxis * _crouchspd, _acc);
    }
    else if (action == action_dash)
    {
        hspd = dsin(dash_dir + 90) * _dashspd;
        vspd = dcos(dash_dir + 90) * _dashspd;
    }
    else if (action == action_backflip)
    {
        if (char == 0)
            hspd = -facing * flipspd;
        else
            hspd = xAxis * 8;
    }
    else if (action == action_slide)
    {
        hspd = approach(hspd, facing * _slidespd, acc_slide);
    }
    else if (slide_jump)
    {
    }
    else
    {
        var _to = xAxis * _runspd;
        var ___acc;
        
        if (on_ground() && sign(_to) == -sign(hspd))
            ___acc = _acc_skid;
        else
            ___acc = _acc;
        
        hspd = approach(hspd, _to, ___acc);
    }
    
    var _force = xAxis != 0;
    
    if ((xAxis != 0 && xAxis != facing) || grounded || (xAxis != 0 && xAxis != sign(hspd)))
        slide_jump = false;
    
    if (skid_animation && grounded && action == action_free && abs(hspd) > 0 && xAxis != 0 && xAxis != sign(hspd) && anim_sprite != player_skid && !skidding && abs(hspd) >= 4)
    {
        if (audio_is_playing(skidSnd))
            audio_stop_sound(skidSnd);
        
        skidSnd = audio_play_sound(snd_skid, 0, false);
        skidding = true;
        event_squish(squish_skid);
    }
    
    if ((action == action_free || action == action_spin) && crouch_input && grounded)
    {
        _action = action;
        
        if (_action == action_spin)
        {
            action = action_crouch_spin;
        }
        else
        {
            action = action_crouch;
            event_squish(squish_crouch);
        }
    }
    
    if ((action == action_crouch || action == action_crouch_spin) && !crouch_input)
    {
        var _nope = false;
        mask_index = mask_normal;
        
        if (solid_meeting(x, y, obj_solid))
            _nope = true;
        
        mask_index = mask_crouch;
        
        if (!_nope)
        {
            _action = action;
            
            if (_action == action_crouch)
                action = action_free;
            else
                action = action_spin;
            
            event_squish(squish_land);
        }
    }
    
    if (coyote_jump > coyote_jump_time && jumps == 0)
        jumps = 1;
    
    if (!solid_above && jumps < jump_max && _input_pressed("jump", player) && !((action == action_crouch || action == action_slide) && solid_above))
    {
        _jumped = true;
        override_sprite = noone;
        part_particles_create(global.part_over, x, y, global.particles.jumpdust, 1);
        audio_play_sound(snd_jump, 0, 0);
        jumps++;
        jumping = true;
        event_squish(squish_jump);
        
        if (jumps == 1)
        {
            with (obj_hamster)
                event_jump();
        }
        
        var _inst = instance_place(x, bbox_bottom + 1, obj_bouncepounce);
        
        if (_inst && y <= _inst.y && grounded)
        {
            with (_inst)
                event_bounce(other.id);
        }
        else if (action == action_slide || action == action_dash)
        {
            hspd = clamp(hspd, -_runspd, _runspd);
            action = action_free;
            timer[timer_reset_action] = -1;
            
            if (jumps == 1)
                vspd = -jump_strength;
            else
                vspd = -spinjump_strength;
            
            slide_jump = true;
        }
        else if (action == action_crouch)
        {
            action = action_backflip;
            vspd = -backflip_strength;
            jumps = 2;
        }
        else if (jumps == 1)
        {
            vspd = -jump_strength;
        }
        else
        {
            vspd = -spinjump_strength;
        }
    }
    
    if (vspd >= 0)
        jumping = false;
    
    if (jumping)
        jumpTimer++;
    else
        jumpTimer = 0;
    
    image_xscale = 1.05;
    var _crate = instance_place(x, y, obj_crate);
    
    if (_crate && state != state_cannon)
    {
        if (state != state_cannon && _crate.object_index == obj_metal_128)
            _crate = noone;
    }
    
    if ((_crate && (coyote_spin || coyote_slide || action == action_dash)) || state == state_cannon)
    {
        if (action == action_dash || _crate.object_index == obj_itemcrate)
        {
            _hspd = hspd;
            timer_func[timer_reset_action]();
            hspd = -_hspd;
        }
        
        with (_crate)
            event_break();
    }
    
    image_xscale = 1;
    
    if (global.throw_boms && _input_pressed("spin", player) && ds_list_size(list_carry) > 0 && throw_fast)
        throw_next = true;
    
    if (global.throw_boms && (_input_pressed("spin", player) || throw_next) && ds_list_size(list_carry) == 0 && (action == action_free || action == action_crouch || action == action_dash || action == action_slide || action == action_throw) && !solid_meeting(x, y, obj_solid))
    {
        throw_next = false;
        
        if (xAxis != 0)
            facing = xAxis;
        
        var _bom = instance_create_layer(x, y, "Instances_Over", obj_bom);
        ds_list_add(list_carry, _bom);
        
        with (_bom)
        {
            col = choose(0, 1, 2, 3, 4);
            carried = other.id;
            facing = other.facing;
        }
        
        timer_func[timer_reset_action]();
        action = action_throw;
        anim_index = 0;
        override_sprite = noone;
        audio_play_sound(snd_throw, 0, 0);
        coyote_slide = 0;
        coyote_spin = 0;
        
        for (var i = 0; i < ds_list_size(list_carry); i++)
        {
            with (ds_list_find_value(list_carry, i))
            {
                throw_now = true;
                throw_facing = facing;
            }
        }
        
        input_verb_consume("spin", player);
    }
    
    if (can_spin)
        scr_player_spin();
    
    var _fat = false;
    var _hspd = hspd;
    
    with (obj_bom_fat)
    {
        if (carried == other.id)
            _fat = true;
    }
    
    if (action != action_slide)
        coyote_slide--;
    
    if ((!grounded || slide_is_dash) && (action == action_free || action == action_spin || action == action_backflip || action == action_slam || action == action_slide) && _input_pressed("dash", player) && !dashed)
    {
        audio_stop_play(snd_dash, 0, 0);
        timer[timer_reset_action] = -1;
        
        if (xAxis == 0 && yAxis == 0)
            xAxis = facing;
        
        _xAxis = horizontal_dash ? xAxis : 0;
        var _yAxis = vertical_dash ? yAxis : 0;
        
        if (full_dash)
            dash_dir = point_direction(0, 0, _xAxis, _yAxis);
        else if (_yAxis > 0)
            dash_dir = 270;
        else if (_yAxis < 0)
            dash_dir = 90;
        else if (_xAxis > 0)
            dash_dir = 0;
        else if (_xAxis < 0)
            dash_dir = -180;
        else if (facing == 1)
            dash_dir = 0;
        else
            dash_dir = -180;
        
        dashed = true;
        slide_jump = false;
        hspd = dsin(dash_dir + 90) * _dashspd;
        vspd = dcos(dash_dir + 90) * _dashspd;
        grav = 0;
        
        if (full_dash || _xAxis != 0)
            facing = sign(hspd);
        
        _action = action;
        
        if (!on_wall(facing))
        {
            var _par;
            
            if (facing == 1)
                _par = global.particles.dashsmokeR;
            else
                _par = global.particles.dashsmokeL;
            
            part_particles_create(global.part_over, x - (10 * facing), y - 40, _par, 1);
        }
        
        override_sprite = noone;
        action = action_dash;
        bounce = false;
        timer[timer_reset_action] = dash_time;
    }
    
    if (grounded && !_jumped && _input_pressed("dash", player) && action != action_slide && action != action_throw && !slide_is_dash)
    {
        override_sprite = noone;
        
        if (xAxis != 0)
            facing = xAxis;
        
        hspd = facing * _slideboost;
        timer_func[timer_reset_action]();
        ds_list_clear(list_spinwait);
        anim_index = 0;
        action = action_slide;
        event_squish(squish_slide);
        coyote_slide = 6;
        timer[timer_reset_action] = slide_time;
        audio_stop_play(snd_dash, 0, 0);
    }
    
    var _xAxis = _input_pressed("right", player) - _input_pressed("left", player);
    
    if (action == action_slide && _xAxis != 0 && _xAxis != facing)
    {
        slide_skid = true;
        timer_func[timer_reset_action]();
    }
    
    if (action != action_slide)
        slide_skid = false;
    
    if (can_dust())
    {
        if (timer[timer_rundust] == -1)
            timer[timer_rundust] = 8;
    }
    else
    {
        timer[timer_rundust] = -1;
    }
    
    if (action == action_slam)
        grav = grav_slam;
    else if (action == action_backflip)
        grav = grav_backflip;
    else if (action == action_dash)
        grav = 0;
    else if (_fat)
        grav = grav_normal + 0.25;
    else
        grav = grav_normal;
    
    if (action != action_free)
        slam_bounce = false;
    
    if (action == action_crouch || action == action_slide || action == action_crouch_spin)
        mask_index = mask_crouch;
    else
        mask_index = mask_normal;
    
    if (global.stage_type == 1)
    {
        _hspd = hspd;
        hspd = _hspd * 0.85;
    }
    
    if (_fat)
        hspd *= 0.65;
    
    physics_apply();
    
    if (_fat && hspd != 0)
        hspd = _hspd;
    
    if (_fat && action == action_slide)
        hspd = facing * slideboost;
    
    if (global.stage_type == 1)
        hspd = _hspd;
    
    if (action == action_slam)
        vspd_max = vspd_max_slam;
    else
        vspd_max = vspd_max_normal;
    
    vspd = min(vspd, vspd_max);
    var _indbefore = anim_index;
    anim_logic();
    
    if ((anim_sprite == player_walk || anim_sprite == spr_buster_walk_carry) && _indbefore < 4 && anim_index >= 4)
    {
        var _max = 4;
        var _grass_stepped = false;
        var _type;
        
        if (place_meeting(x, y + 1, obj_footstep_grass))
        {
            _type = "grass";
            _max = 3;
            audio_play_sound(asset_get_index($"snd_footstep_{_type}{irandom_range(0, _max)}"), 0, 0);
            _grass_stepped = true;
        }
        
        if (place_meeting(x, y + 1, obj_pipe) || place_meeting(x, y + 1, obj_metalsolid) || place_meeting(x, y + 1, obj_conveyor_semi) || place_meeting(x, y + 1, obj_caution_semisolid) || place_meeting(x, y + 1, obj_caution_solid) || place_meeting(x, y + 1, obj_footstep_metal))
            _type = "metal";
        else
            _type = "concrete";
        
        var _snd = audio_play_sound(asset_get_index($"snd_footstep_{_type}{irandom_range(0, _max)}"), 0, 0);
        
        if (_grass_stepped)
            audio_sound_gain(_snd, 0.65, 0);
    }
    
    if (override_sprite != noone)
        exit;
    
    if (action == action_dazed)
    {
        anim_play(spr_buster_pain2);
        exit;
    }
    else if (action == action_backflip)
    {
        anim_play(_backflip);
        exit;
    }
    else if (action == action_spin)
    {
        anim_play(player_spin);
        exit;
    }
    else if (action == action_crouch_spin)
    {
        anim_play(spr_buster_crouchspin);
        exit;
    }
    else if (action == action_dash)
    {
        anim_play(_dash);
        exit;
    }
    else if (action == action_slide)
    {
        anim_sprite = _slide;
        exit;
    }
    else if (action == action_throw)
    {
        anim_sprite = player_throw;
        exit;
    }
    
    if (on_ground())
    {
        if (skidding)
        {
            anim_play_player(_skid, _skid_carry);
        }
        else if ((xAxis == 0 && hspd == 0) || (action != action_crouch && on_wall(xAxis)))
        {
            if (action == action_crouch)
                anim_play(_crouch);
            else
                anim_play(_idle);
        }
        else if (action == action_crouch)
        {
            anim_play(_crouchwalk);
        }
        else
        {
            anim_play_player(_walk, _walk_carry);
        }
    }
    else if (slam_bounce)
    {
        anim_play(player_bounce);
    }
    else if (jumps > 1)
    {
        anim_play(_djump);
    }
    else if (bounce)
    {
        anim_play(_jump_bounce);
    }
    else
    {
        anim_play(_jump);
    }
    
    if (!on_ground() || hspd == 0 || sign(hspd) == facing || xAxis == -facing || action != action_free)
        skidding = false;
    
    anim_speed = 1;
    
    if ((anim_sprite == player_walk || anim_sprite == spr_buster_walk_carry) && global.invincible)
        anim_speed = 1.2;
    
    if (action == action_throw && anim_index >= 1)
        action = action_free;
}
