dead = false;
grounded = false;
bonus_freeze = false;
blood_burst_amount_offset = false;
deac_controls = false;
deac_allow_spin = false;
squish_land = 0;
squish_jump = 1;
squish_crouch = 2;
squish_slide = 3;
squish_skid = 4;
squish = squish_land;
squish_percent = 1;

event_squish = function(arg0)
{
    squish = arg0;
    squish_percent = 0;
};

throw_fast = false;
throw_next = false;
transform_player = 0;
transform = transform_player;
recording = false;
record_frames = [];
xAxis = 0;
yAxis = 0;
crouch_input = false;
auto_facing = 1;
override_facing = 1;

reset_action = function()
{
    hspd = 0;
    vspd = 0;
    timer_func[timer_reset_action]();
    jumps = 0;
    grav = grav_normal;
    aframe_delay = -1;
};

physics_init();
array_push(move_forces[0], "hspd_bounce");
hspd_bounce = 0;
bounce = false;
runspd = 12;
runspd_nuclear = 14;
crouchspd = 4;
crouchspd_nuclear = 6;
flipspd = 6;
dashspd = 15;
dashspd_nuclear = 16;
slideboost = 15.5;
slideboost_nuclear = 16.5;
slidespd = 12;
slidespd_nuclear = 13;
acc = 1.2;
acc_nuclear = 1.4;
acc_slide = 0.5;
grav_normal = 1.7;
grav_fat = 1.95;
grav_backflip = 1.9;
grav_slam = 5;
grav = grav_normal;
vspd_max_normal = 32;
vspd_max_slam = 40;
vspd_max_hurt = 20;
jumps = 0;
vspd_max = vspd_max_normal;

ground_reset_actions = function()
{
    var _action = action;
    
    if (_action == action_backflip)
        action = action_free;
    
    variable_jump = false;
    jumps = 0;
    coyote_jump = 0;
    variable_jump = false;
    dashed = false;
};

jump_strength = calculate_jump(3.2, grav_normal);
spinjump_strength = calculate_jump(1.35, grav_normal);
backflip_strength = calculate_jump(5, grav_backflip);
slam_strength = calculate_jump(5.1, grav_normal);
coyote_jump = 0;
jumping = false;
jumpTimer = 0;
bounce_blocks_hold = 2;
bounce_blocks = 1;
slam_bounce = false;
state_free = 0;
state_hurt = 1;
state_powerup = 2;
state_deac = 3;
state_intro = 4;
state_cannon = 5;
state_hurt_coop = 6;
state_mud = 7;
state = state_free;

set_palette = function()
{
    if (global.invincible)
    {
        if (meter_flash)
            myPal = global.palette[global.player_character[player]] + 1;
        else
            myPal = sprite_get_width(pal_sprite) - 1;
    }
    else
    {
        myPal = global.palette[global.player_character[player]] + 1;
        meter_flash = false;
    }
};

cannon_shot = false;
ignore_cannon = noone;
my_cannon = noone;
cannon_free = false;
action_free = 0;
action_crouch = 1;
action_crouch_spin = 2;
action_spin = 3;
action_dash = 4;
action_backflip = 5;
action_slide = 6;
action_slam = 7;
action_throw = 8;
action_dazed = 9;
action = action_free;
dash_time = 15;
spin_time = 20;
slide_time = 25;
slide_jump = false;
auto_slide = true;
slide_skid = false;
dashed = false;
coyote_spin = 0;
coyote_slide = 0;
spr_prev = 0;
ind_prev = 0;
invulnerable = false;
invulnerable_flash = false;

event_check_enemy_stomp = function()
{
    if (place_meeting(x, y + 1, par_enemy) && !(vspd < 0))
    {
        var _enemy = instance_place(x, y + 1, par_enemy);
        
        if (_enemy && _enemy.stompable && y <= (_enemy.bbox_top + 4))
        {
            with (_enemy)
            {
                hitBy = other;
                hurt_delay = 10;
                event_user(0);
            }
            
            while (place_meeting(x, y + 10, _enemy))
                y--;
            
            event_bounce_enemy();
            return false;
        }
    }
};

event_ymove = function()
{
    event_check_enemy_stomp();
    return true;
};

event_wall = function()
{
    var _crate = instance_place(x + sign(hspd), y, obj_crate);
    
    if (_crate && state != state_cannon)
    {
        if (state != state_cannon && _crate.object_index == obj_metal_128)
            _crate = noone;
    }
    
    if ((_crate && (coyote_spin || coyote_slide || action == action_dash)) || state == state_cannon)
    {
        if (action == action_dash || _crate.object_index == obj_itemcrate)
        {
            var _hspd = hspd;
            timer_func[timer_reset_action]();
            hspd = -_hspd;
        }
        
        with (_crate)
            event_break();
        
        exit;
    }
    
    if (place_meeting(x + sign(hspd), y, obj_reverseblock))
    {
        var _block = instance_place(x + sign(hspd), y, obj_reverseblock);
        auto_facing = sign(_block.image_xscale);
        
        if (sign(hspd) != auto_facing)
            hspd = 14 * auto_facing;
    }
    else
    {
        hspd = 0;
    }
    
    if (place_meeting(x + sign(hspd), y, obj_solid))
    {
        hspd = 0;
        slide_jump = false;
    }
};

event_bounce = function()
{
    var _input = (global.players > 1) ? input_check : input_check_all;
    override_sprite = noone;
    timer[timer_reset_action] = -1;
    timer_func[timer_reset_action]();
    
    if (_input("jump", player))
        vspd = -calculate_jump(bounce_blocks_hold, grav);
    else
        vspd = -calculate_jump(bounce_blocks, grav);
    
    jumps = 1;
    dashed = 0;
    bounce_blocks = 1;
    bounce_blocks_hold = jump_strength;
    bounce = true;
    override_facing = facing;
};

event_bounce_enemy = function()
{
    var _input = (global.players > 1) ? input_check : input_check_all;
    override_sprite = noone;
    jumps = 1;
    dashed = 0;
    var _action = action;
    timer[timer_reset_action] = -1;
    timer_func[timer_reset_action]();
    
    if (_input("jump", player))
        vspd = -jump_strength - 1.5;
    else
        vspd = -12;
    
    if (_action == action_slam)
    {
        if (crouch_input)
        {
        }
        else
        {
            slam_bounce = true;
            vspd = -slam_strength;
            jumps = 2;
        }
    }
};

list_carry = ds_list_create();
list_spinwait = ds_list_create();
skidSnd = noone;

event_floor = function()
{
    cannon_shot = false;
    ignore_cannon = noone;
    state = state_free;
    aframe_delay = -1;
    
    if (vspd > 0)
    {
        for (var i = 0; i < ds_list_size(list_carry); i++)
        {
            var _pound;
            
            if (vspd >= 15)
                _pound = true;
            else
                _pound = false;
            
            with (ds_list_find_value(list_carry, i))
                pounded = _pound;
        }
    }
    
    scr_player_floor_free();
};

event_ceiling = function()
{
    var _crate = instance_place(x, y - 1, obj_crate);
    
    if (_crate)
    {
        with (_crate)
            event_break();
        
        if (!coyote_spin && state != state_cannon)
            vspd = 0;
        
        part_particles_create(global.part_over, x, bbox_top, global.particles.smack, 1);
        exit;
    }
    
    vspd = 0;
    
    if (place_meeting(x, y - 2, par_block))
    {
        part_particles_create(global.part_over, x, bbox_top, global.particles.smack, 1);
        var _list = ds_list_create();
        instance_place_list(x, y - 2, par_block, _list, true);
        
        for (var i = 0; i < ds_list_size(_list); i++)
        {
            with (ds_list_find_value(_list, i))
                event_user(0);
        }
        
        ds_list_destroy(_list);
    }
};

can_dust = function()
{
    if (skidding)
        return false;
    
    return xAxis != 0 && !solid_meeting(x + xAxis, y, obj_solid) && !on_wall(xAxis) && grounded && action == action_free && abs(hspd) > 0;
};

anim_init();
facing = 1;
aframe_delay = -1;
flash_white = false;
flash_white_alpha = 0;
flash_white_percent = 0;

event_flash_white = function()
{
    flash_white = true;
    flash_white_alpha = 0;
    flash_white_percent = 0;
};

land_anim_delay = 0;
xscale_squish = 1;
yscale_squish = 1;
skidding = false;

event_animend = function()
{
    switch (anim_sprite)
    {
        case spr_buster_win:
        case spr_bridget_win:
        case spr_buster_win_tutorial:
        case spr_bridget_win_tutorial:
            anim_index = sprite_get_number(anim_sprite) - 1 - 2;
            break;
        
        case spr_buster_skid:
        case spr_buster_skid_carry:
        case spr_buster_skid_goggles:
        case spr_bridget_skid:
        case spr_bridget_skid_carry:
        case spr_bridget_skid_goggles:
            anim_index = 1;
            break;
        
        case spr_buster_jump:
        case spr_buster_jump_carry:
        case spr_buster_jump_goggles:
            anim_index = sprite_get_number(anim_sprite) - 1 - 2;
            break;
        
        case spr_buster_doublejump:
        case spr_buster_doublejump_carry:
        case spr_buster_doublejump_goggles:
        case spr_bridget_doublejump:
        case spr_bridget_doublejump_carry:
        case spr_bridget_doublejump_goggles:
            anim_index = sprite_get_number(anim_sprite) - 1 - 2;
            break;
        
        case spr_buster_slide:
        case spr_buster_slide_carry:
        case spr_buster_slide_goggles:
        case spr_bridget_slide:
        case spr_bridget_slide_carry:
        case spr_bridget_slide_goggles:
            anim_index = 2;
            break;
        
        case spr_buster_backflip:
        case spr_buster_backflip_goggles:
        case spr_buster_cannonshoot:
        case spr_bridget_cannonshoot:
            anim_index = 4;
            break;
        
        case spr_bridget_backflip:
        case spr_bridget_backflip_goggles:
            anim_index = sprite_get_number(spr_bridget_backflip) - 1 - 2;
            break;
        
        case spr_buster_taunt:
        case spr_bridget_taunt:
            state = state_free;
            global.freeze = 0;
            anim_play(player_idle);
            break;
        
        case spr_buster_throw:
        case spr_bridget_throw:
            action = action_free;
            break;
        
        case spr_bridget_confused_0:
            anim_play(spr_bridget_confused_1);
            break;
    }
    
    if (override_sprite != noone)
        override_sprite = noone;
};

pit = false;
dazed = false;
timer_reset_action = 0;
timer_rundust = 1;
timer_reset_state = 2;
timer_invulnerable_flash = 3;
timer_become_vulnerable = 4;
timer_pit = 5;
timer_meterflash = 6;
timer_leave_hurt = 7;
timer[timer_reset_action] = -1;

timer_func[timer_reset_action] = function()
{
    timer[timer_reset_action] = -1;
    var _action = action;
    solid_above = solid_meeting(x, y - 8, obj_solid);
    var _newaction;
    
    if (action == action_crouch || action == action_slide || action == action_crouch_spin)
        _newaction = action_crouch;
    else
        _newaction = action_free;
    
    if (_action == action_dash)
    {
        grav = grav_normal;
    }
    else if (_action == action_slide)
    {
        if (solid_above)
        {
            if (hspd == 0 || !auto_slide || slide_skid)
                action = action_crouch;
            else
                timer[timer_reset_action] = 1;
            
            _newaction = noone;
        }
        else
        {
        }
    }
    else if (_action == action_crouch_spin)
    {
        _newaction = action_crouch;
    }
    
    if (_newaction != noone)
        action = _newaction;
};

timer[timer_rundust] = -1;

timer_func[timer_rundust] = function()
{
    if (dust_run)
    {
        var _dust = instance_create_layer(x - (10 * facing), y, "Particles_Over", obj_fx_dust);
        _dust.hspd = -facing * 4;
        var _scale = 1.3;
        _dust.image_xscale = _scale;
        _dust.image_yscale = _scale;
    }
};

state_to = state_free;
timer[timer_reset_state] = -1;

timer_func[timer_reset_state] = function()
{
    var _state = state;
    state = state_to;
    state_to = state_free;
};

timer[timer_invulnerable_flash] = -1;

timer_func[timer_invulnerable_flash] = function()
{
    invulnerable_flash = !invulnerable_flash;
    timer[timer_invulnerable_flash] = 5;
};

timer[timer_become_vulnerable] = -1;

timer_func[timer_become_vulnerable] = function()
{
    invulnerable = false;
    hurt_by = noone;
    timer[timer_invulnerable_flash] = -1;
};

timer[timer_pit] = -1;

timer_func[timer_pit] = function()
{
    part_particles_create(global.part_over, x, y - 70, global.particles.smoke, 1);
    instance_destroy();
    var _inst = instance_create_layer(pit_respawn_x, pit_respawn_y, layer, obj_player);
    obj_controller.relative_pos_ease = 0;
    
    with (_inst)
    {
        invulnerable = true;
        timer[timer_invulnerable_flash] = 5;
        invulnerable_flash = true;
        timer[timer_become_vulnerable] = 120;
    }
};

timer[timer_meterflash] = -1;

timer_func[timer_meterflash] = function()
{
    meter_flash = !meter_flash;
};

meter_flash = false;
timer[timer_leave_hurt] = -1;

timer_func[timer_leave_hurt] = function()
{
    state = state_before_hurt;
    timer[timer_invulnerable_flash] = 5;
    invulnerable_flash = true;
    timer[timer_become_vulnerable] = 120;
};

powerup_index_change[0] = -4;
powerup_index_change[1] = -4;
powerup_index_change[2] = 23;
mySnd_nuclear = noone;
transformed = false;
player = 0;

if (object_index == obj_player && global.players > 1)
{
    x += 64;
    var _inst = instance_create_layer(x - 128, y, layer, obj_player2);
}

char = 0;

char_reload = function()
{
    var _pal = [pal_buster, pal_bridget];
    var _idle = [spr_buster_idle, spr_bridget_idle];
    var _spin = [spr_buster_spin, spr_bridget_spin];
    var _walk = [spr_buster_walk, spr_bridget_walk];
    var _skid = [spr_buster_skid, spr_bridget_skid];
    var _jump = [spr_buster_jump, spr_bridget_jump];
    var _djump = [spr_buster_doublejump, spr_bridget_doublejump];
    var _slide = [spr_buster_slide, spr_bridget_slide];
    var _crouch = [spr_buster_crouch, spr_bridget_crouch];
    var _crouchwalk = [spr_buster_crouchwalk, spr_bridget_crouchwalk];
    var _dash = [spr_buster_dash, spr_bridget_dash];
    var _idle_carry = [spr_buster_idle_carry, spr_bridget_idle_carry];
    var _walk_carry = [spr_buster_walk_carry, spr_bridget_walk_carry];
    var _jump_carry = [spr_buster_jump_carry, spr_bridget_jump_carry];
    var _djump_carry = [spr_buster_doublejump_carry, spr_bridget_doublejump_carry];
    var _slide_carry = [spr_buster_slide_carry, spr_bridget_slide_carry];
    var _skid_carry = [spr_buster_skid_carry, spr_bridget_skid_carry];
    var _crouch_carry = [spr_buster_crouch_carry, spr_bridget_crouch_carry];
    var _crouchwalk_carry = [spr_buster_crouchwalk_carry, spr_bridget_crouchwalk_carry];
    var _dash_carry = [spr_buster_dash_carry, spr_bridget_dash];
    var _bounce = [spr_buster_spring, spr_bridget_spring];
    var _confused = [spr_buster_confused, spr_bridget_confused_0];
    var _win = [spr_buster_win, spr_bridget_win];
    var _win_tutorial = [spr_buster_win_tutorial, spr_bridget_win_tutorial];
    var _taunt = [spr_buster_taunt, spr_bridget_taunt];
    var _throw = [spr_buster_throw, spr_bridget_throw];
    player_idle = _idle[char];
    player_spin = _spin[char];
    player_walk = _walk[char];
    player_skid = _skid[char];
    player_jump = _jump[char];
    player_djump = _djump[char];
    player_slide = _slide[char];
    player_crouch = _crouch[char];
    player_crouchwalk = _crouchwalk[char];
    player_dash = _dash[char];
    player_bounce = _bounce[char];
    player_win = _win[char];
    player_win_tutorial = _win_tutorial[char];
    player_idle_carry = _idle_carry[char];
    player_walk_carry = _walk_carry[char];
    player_jump_carry = _jump_carry[char];
    player_djump_carry = _djump_carry[char];
    player_slide_carry = _slide_carry[char];
    player_skid_carry = _skid_carry[char];
    player_crouch_carry = _crouch_carry[char];
    player_crouchwalk_carry = _crouchwalk_carry[char];
    player_dash_carry = _dash_carry[char];
    player_confused = _confused[char];
    player_throw = _throw[char];
    player_taunt = _taunt[char];
    pal_sprite = _pal[char];
    set_palette();
};

char_reload();
set_char = false;
hurt_by = noone;
dust_land = 0;
dust_jump = 1;

event_dust = function(arg0 = dust_land)
{
    var _xmax, _xmin;
    
    if (arg0 == dust_land)
    {
        _xmin = -18;
        _xmax = 18;
    }
    else
    {
        _xmin = -12;
        _xmax = 12;
    }
    
    var _count;
    
    if (arg0 == dust_land)
        _count = irandom_range(5, 6);
    else
        _count = irandom_range(4, 5);
    
    var _div = (_xmax - _xmin) / _count;
    var _xpos = [];
    
    for (var i = 0; i < _count; i++)
        _xpos[i] = _xmin + (_div * i);
    
    for (var i = 0; i < _count; i++)
    {
        var _x = x + _xpos[i];
        var _y = y;
        
        if (arg0 == dust_land)
            _y = (y - 14) + irandom_range(0, 6);
        
        var _dust = instance_create_layer(_x, _y, "Particles_Over", obj_fx_dust);
        
        if (_x > x)
            _dust.hspd = random_range(2, 5);
        else
            _dust.hspd = random_range(-2, -5);
        
        if (arg0 == dust_jump)
            _dust.vspd = random_range(1, 4);
        
        var _scale = random_range(1.1, 1.3);
        _dust.image_xscale = _scale;
        _dust.image_yscale = _scale;
    }
};
