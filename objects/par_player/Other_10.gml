if (instance_exists(obj_wizardevent_win))
    exit;

voice_delay = 12;

event_reset = function()
{
    global.combo_meter = 0;
    invulnerable = true;
    timer_func[timer_reset_action]();
    coyote_spin = 0;
    coyote_slide = 0;
    
    if (state != state_cannon && !dazed)
    {
        hspd = -facing * 4;
        vspd = -12;
        state = state_hurt;
        timer[timer_reset_state] = 15;
        land_anim_delay = 5;
        var _char;
        
        if (global.player_character[player] == 0)
            _char = "buster";
        else
            _char = "bridget";
        
        anim_sprite = asset_get_index($"spr_{_char}_pain{irandom_range(0, 2)}");
        anim_index = 0;
    }
    
    if (!is_coop)
    {
        global.hurt = id;
        
        if (pit)
            global.freeze = 1;
        else
            global.freeze = 25;
        
        global.freeze_func = function()
        {
            with (global.hurt)
            {
                timer[timer_invulnerable_flash] = 5;
                invulnerable_flash = true;
                timer[timer_become_vulnerable] = 120;
            }
            
            global.hurt = noone;
        };
    }
    else
    {
        state_before_hurt = state;
        
        if (pit)
            timer[timer_leave_hurt] = 1;
        else
            timer[timer_leave_hurt] = 25;
        
        state = state_hurt_coop;
    }
    
    pit = false;
    dazed = false;
};

var _voices;

if (global.player_character[player] == 0)
    _voices = [voice_buster_ow_0, voice_buster_ow_1, voice_buster_dammit, voice_buster_awkward, voice_buster_urnotevengood, voice_buster_fuckintrash, voice_buster_thehorror, voice_buster_phony, voice_buster_noo];
else
    _voices = [voice_bridget_ow0, voice_bridget_ow1, voice_bridget_ow2, voice_bridget_dammit0, voice_bridget_dammit1, voice_bridget_sorryidied, voice_bridget_straightbuns, voice_bridget_umok, voice_bridget_misinputsorry, voice_bridget_wtfiswrongwithu, voice_bridget_yousuckatthisshit];

pick_voice = function(arg0)
{
    var _num = irandom_range(0, array_length(arg0) - 1);
    death_voice = arg0[_num];
};

pick_voice(_voices);
var _char = char;
var _pal = global.palette[global.player_character[player]];
var _facing = facing;
global.powerup = 0;

if (global.players > 1)
    is_coop = true;
else
    is_coop = false;

if (!pit && (invulnerable || obj_controller.win || global.invincible))
    exit;

var _blood_burst = true;
var _blood_sound = true;
var _visible = true;
var _guts = false;
var _coins = true;
var _restart_delay = 0;
var _bubble = global.bubble;

if (_bubble)
{
    global.bubble = false;
    play_impact();
    screen_shake(12, 12);
    event_reset();
    audio_play_sound(snd_losepowerup, 0, false);
    exit;
}

if (hurt_by != noone && !_bubble)
{
    if (hurt_by == obj_paused)
    {
        _guts = true;
        _visible = false;
        _blood_burst = true;
    }
    else if (hurt_by.object_index == obj_lightning)
    {
        _visible = false;
        _blood_burst = false;
        _blood_sound = false;
        var _inst = instance_create_layer(x, y, layer, obj_player_death_zap);
        _inst.facing = facing;
        _inst.lightning = hurt_by;
        _inst.char = global.player_character[player];
        _inst.player = player;
        var _sprs = [spr_buster_death_zap, spr_bridget_death_zap];
        
        with (_inst)
            anim_play(_sprs[char]);
        
        scr_get_achievement("LIGHTNING");
        
        with (hurt_by)
            zapped_player = true;
        
        _restart_delay = 30;
    }
    else if (hurt_by.object_index == obj_firebar_fireball || hurt_by.object_index == obj_lava || hurt_by.object_index == obj_fireball)
    {
        if (global.player_character[player] == 0)
            _voices = [voice_buster_scream_0];
        else
            _voices = [voice_bridget_scream_0];
        
        voice_delay = 2;
        _visible = false;
        _blood_burst = false;
        _blood_sound = false;
        var _inst = instance_create_layer(x, y, layer, obj_player_death_zap);
        _inst.facing = facing;
        _inst.lightning = hurt_by;
        _inst.char = global.player_character[player];
        _inst.fire = true;
        _inst.player = player;
        var _sprs = [spr_buster_death_fire, spr_bridget_death_fire];
        
        with (_inst)
            anim_play(_sprs[char]);
        
        scr_get_achievement("FIRE");
        
        if (hurt_by.object_index == obj_lava)
            _inst.lava = true;
        
        var _snd = audio_play_sound(snd_flame, 0, false);
        audio_sound_gain(_snd, 1.45, 0);
        audio_sound_pitch(_snd, 1.3);
        
        with (hurt_by)
            zapped_player = true;
        
        _restart_delay = 30;
    }
    else if (hurt_by.object_index == obj_buzzsaw)
    {
        if (global.player_character[player] == 0)
            _voices = [voice_buster_scream_0, voice_buster_scream_1, voice_buster_scream_2, voice_buster_awkward, voice_buster_headache, voice_buster_whoopsha, voice_buster_awshucks, voice_buster_ohshoot];
        else
            _voices = [voice_bridget_scream_0, voice_bridget_scream_1];
        
        audio_play_sound(snd_buzzsaw, 0, false);
        _blood_burst = true;
        _guts = true;
        _visible = false;
        voice_delay = 2;
        
        with (obj_buzzsaw)
        {
            if (place_meeting(x, y, other))
            {
                anim_index++;
                
                if (anim_index > (sprite_get_number(anim_sprite) - 1))
                    anim_index = sprite_get_number(anim_sprite) - 1;
                
                var _data = 
                {
                    object_index: object_index,
                    x: xstart,
                    y: ystart
                };
                screen_shake(16, 16, 0.85);
                
                if (array_length(global.hurt_remember) < 100)
                    array_push(global.hurt_remember, _data);
            }
        }
    }
    else if (hurt_by.object_index == obj_ball)
    {
        global.ball_clean = false;
        
        if (y <= (hurt_by.y - 48))
        {
            _visible = false;
            _blood_burst = true;
            _blood_sound = false;
            blood_burst_amount_offset = -55;
            audio_play_sound(snd_stab, 0, false);
            var _spr;
            
            if (global.player_character[char] == 0)
                _spr = spr_ball_impaled;
            else
                _spr = spr_ball_impaled_bridget;
            
            with (hurt_by)
                anim_sprite = _spr;
        }
    }
    else if (hurt_by.object_index == obj_spike)
    {
        voice_delay = 8;
        var _spikes = instance_place_array(x, y + 6, obj_spike);
        array_sort(_spikes, function(arg0, arg1)
        {
            var _dist_a = point_distance(obj_player.x, obj_player.y, arg0.x + 32, arg0.y);
            var _dist_b = point_distance(obj_player.x, obj_player.y, arg1.x + 32, arg1.y);
            return _dist_a - _dist_b;
        });
        var _spike;
        
        if (array_length(_spikes) > 0)
            _spike = _spikes[0];
        else
            _spike = noone;
        
        with (_spike)
        {
            var _sprs = [spr_spike_impaled_buster, spr_spike_impaled_bridget];
            var _max = sprite_get_number(_sprs[_char]) - 1;
            var _index = irandom_range(0, _max);
            var _data = 
            {
                object_index: object_index,
                x: xstart,
                y: ystart,
                char: _char,
                palette: _pal,
                facing: _facing,
                anim_index: _index
            };
            
            for (var i = 0; i < array_length(global.hurt_remember_players); i++)
            {
                var _inst = global.hurt_remember_players[i];
                
                if (_inst.object_index == object_index && _inst.x == xstart && _inst.y == ystart)
                {
                    array_delete(global.hurt_remember_players, i, 1);
                    
                    with (obj_spike_impale)
                    {
                        if (my_spike == other.id)
                            instance_destroy();
                    }
                }
            }
            
            array_push(global.hurt_remember_players, _data);
            event_impale(_pal, _char, _facing, _index);
        }
        
        _visible = false;
        _blood_burst = true;
        _blood_sound = false;
        screen_shake(16, 16, 0.85);
        audio_play_sound(snd_stab, 0, false);
    }
    else if (hurt_by.object_index == obj_bom || hurt_by.object_index == obj_bom_fat || hurt_by.object_index == obj_landmine || hurt_by.object_index == obj_bom_anxious)
    {
        _visible = false;
        _blood_burst = true;
        _guts = true;
    }
    else if (hurt_by.object_index == obj_ritz || hurt_by.object_index == obj_pinky_pellet)
    {
        _visible = false;
        _blood_burst = true;
        _guts = true;
    }
}

var _powerup_is_hp = false;
var _powerup = global.powerup;

if (_powerup != 0 && _powerup_is_hp)
{
    event_reset();
    global.powerup = 0;
}
else if (global.hp <= 1)
{
    if (_coins)
    {
        if (global.food_got)
        {
            if (instance_exists(obj_food))
            {
                with (obj_food)
                    instance_destroy();
            }
            
            var _x = x;
            var _y = y - 48;
            _x += random_range(-32, 32);
            _y += random_range(-32, 32);
            _inst = instance_create_layer(_x, _y, "Particles_Over", obj_gut);
            _inst.anim_sprite = spr_food;
            _inst.mask_index = spr_coin_die;
            _inst.yoff = -32;
            _inst.anim_index = global.round;
            _inst.vspd = -10;
            _inst.hspd = random_range(-5, 5);
            _inst.grav = 0.75;
            _inst.anim_speed = 0;
        }
        
        for (var i = 0; i < min(global.coins_collected, 50); i++)
        {
            var _x = x;
            var _y = y - 48;
            _x += random_range(-32, 32);
            _y += random_range(-32, 32);
            _inst = instance_create_layer(_x, _y, "Particles_Over", obj_gut);
            _inst.anim_sprite = spr_coin;
            _inst.mask_index = spr_coin_die;
            _inst.yoff = -32;
            _inst.anim_index = i;
            _inst.vspd = -10;
            _inst.hspd = random_range(-5, 5);
            _inst.grav = 0.75;
        }
        
        screen_shake(16, 16, 0.85);
    }
    
    var _sprs = [spr_gut_draw, spr_gut_draw_bridget];
    var _spr = _sprs[char];
    
    if (_guts)
    {
        for (var i = 0; i < (sprite_get_number(spr_gut_draw) - 1); i++)
        {
            var _x = x;
            var _y = y - 48;
            _x += random_range(-32, 32);
            _y += random_range(-32, 32);
            _inst = instance_create_layer(_x, _y, "Particles_Over", obj_gut);
            _inst.anim_sprite = _spr;
            _inst.mask_index = spr_gut_collide;
            _inst.anim_index = i;
            _inst.vspd = random_range(-10, -16);
            _inst.hspd = random_range(-12, 12);
            
            if (i == 7 || i == 11)
                _inst.grav = 1.1;
            else
                _inst.grav = 0.45;
            
            _inst.anim_speed = 0;
            _inst.char = char;
            _inst.player = player;
        }
        
        _visible = false;
        _blood_burst = true;
    }
    
    var _inst = instance_create_layer(x, y, layer, obj_player_death);
    _inst.facing = facing;
    _inst.visible = _visible;
    _inst.restart_delay = _restart_delay;
    _inst.player = player;
    dead = true;
    global.bubble = false;
    
    with (par_player)
    {
        if (!dead)
        {
            invulnerable = false;
            event_user(0);
        }
    }
    
    if (global.player_character[player] == 0)
        _inst.anim_sprite = spr_buster_pain3;
    else
        _inst.anim_sprite = spr_bridget_pain3;
    
    if (player == 0)
    {
        if (!global.round_select)
        {
            if (global.bside)
                global.save.deaths_B++;
            else
                global.save.deaths_A++;
        }
    }
    
    scr_get_achievement("DIE");
    
    if (_blood_burst)
    {
        event_user(2);
        
        if (_blood_sound)
            audio_play_sound(snd_blood, 0, false);
    }
    
    global.hp = 0;
    pick_voice(_voices);
    
    if (global.voice_clips)
        audio_play_sound_delay(death_voice, voice_delay, 1.1);
    
    instance_destroy();
    exit;
}
