if (file_exists(game_save_id + "save.json"))
    global.save = load_json(game_save_id + "save.json");

start = false;
start_done = false;
surf = noone;
var i = 0;

while (audio_exists(i))
{
    if (bgm_title == i || snd_explosion_title == i)
    {
        i++;
        continue;
    }
    
    if (audio_is_playing(i))
        audio_stop_sound(i);
    
    i++;
}

if (!audio_is_playing(bgm_title))
    global.bgm_play = audio_play_sound(bgm_title, 0, true);

go = false;
timer[0] = -1;

timer_func[0] = function()
{
    room_goto_fade(rm_cutscene_opening, 180);
    audio_sound_gain(global.bgm_play, 0, 1500);
};

init_game_globals();

if (!global.round_select)
{
    global.player_character[0] = 0;
    global.player_character[1] = 1;
}

global.players = 1;
global.world = 1;
global.stage = 1;
global.act = 1;
global.stage_type = 0;
global.stage_load = undefined;
global.acts = 1;
global.act_name = "Undefined";
anim_idle = 0;
anim_look = 1;
anim_smug = 2;
anim_crazy = 3;
anim_walk = 4;
buster_anim = anim_idle;
right_width = sprite_get_width(spr_title_box);
left_width = 1920 - right_width;

buster_play = function(arg0)
{
    if (buster_spr != arg0)
    {
        buster_spr = arg0;
        buster_ind = 0;
    }
};

event_pause = function(arg0)
{
    pause = arg0;
};

event_buster_reset = function()
{
    buster_spr = spr_title_buster;
    buster_ind = 0;
    buster_angle = 0;
    buster_hspd = 0;
    buster_vspd = 0;
    buster_grav = 0;
    buster_x = left_width / 2;
    buster_y = 1080;
    buster_xscale = 1;
    buster_yscale = 1;
    buster_facing = 1;
    timeline_pos = 0;
    timeline = [];
    pause = 0;
    bom_rise = false;
    bom_hand_yoff_max = 480;
    bom_hand_yoff = bom_hand_yoff_max;
    bom_percent = 1;
    bom_in = false;
    bom_down = false;
    launch = false;
    walk = false;
    walk_away = false;
    buster_xto = buster_x;
    cartwheel = false;
};

event_buster_anim_idle = function()
{
    event_buster_reset();
};

event_buster_anim_look = function()
{
    event_buster_reset();
    timeline = [function()
    {
        buster_spr = spr_title_buster_blink;
    }, function()
    {
        event_pause(10);
    }, function()
    {
        buster_spr = spr_title_buster_lookL;
    }, function()
    {
        event_pause(85);
    }, function()
    {
        buster_spr = spr_title_buster_blink;
    }, function()
    {
        event_pause(10);
    }, function()
    {
        buster_spr = spr_title_buster;
    }];
};

event_buster_anim_smug = function()
{
    event_buster_reset();
    timeline = [function()
    {
        buster_play(spr_title_buster_smug_inb);
    }, function()
    {
        event_pause(240);
    }, function()
    {
        buster_play(spr_title_buster_smug_inb_out);
    }];
};

event_buster_anim_crazy = function()
{
    event_buster_reset();
    timeline = [function()
    {
        buster_play(spr_title_buster_crazy_inb);
    }, function()
    {
        event_pause(60);
    }, function()
    {
        bom_rise = true;
        bom_percent = 0;
        bom_in = true;
    }, function()
    {
        event_pause(170);
    }, function()
    {
        bom_rise = false;
        bom_percent = 0;
        bom_down = true;
        wizard_rise = choose(true, false);
        
        if (wizard_rise)
        {
            event_pause(660);
            timer[1] = 210;
        }
        else
        {
            event_pause(240);
        }
    }, function()
    {
        bom_down = false;
        walk_facing = choose(-1, 1);
        event_buster_anim_walk();
        timeline[0]();
        timeline_pos++;
    }];
};

event_buster_anim_zoomies = function()
{
    event_buster_reset();
    timeline = [function()
    {
        buster_play(spr_title_buster_woahL);
        event_pause(60);
    }, function()
    {
        buster_play(spr_title_buster_woahR);
        event_pause(60);
    }, function()
    {
        buster_play(spr_title_buster_launch_prep);
        event_pause(30);
    }, function()
    {
        buster_play(spr_title_buster_launch);
        buster_hspd = 17.5;
        buster_vspd = -50;
        buster_grav = 1.75;
        launch = true;
        event_pause(65);
    }, function()
    {
        screen_shake(10, 10, 0.28);
        event_pause(120);
    }, function()
    {
        launch = false;
        buster_hspd = 0;
        buster_vspd = 0;
        buster_grav = 0;
        buster_y = 1080;
        walk_facing = 1;
        event_buster_anim_cartwheel();
        timeline[0]();
    }];
};

event_buster_anim_walk = function()
{
    event_buster_reset();
    timeline = [function()
    {
        buster_facing = walk_facing;
        buster_play(spr_title_buster_walk);
        buster_x = (left_width / 2) - (900 * walk_facing);
        walk = true;
        buster_xto = left_width / 2;
    }];
};

event_buster_anim_cartwheel = function()
{
    event_buster_reset();
    timeline = [function()
    {
        buster_angle = 0;
        cartwheel = true;
        buster_play(spr_title_buster_cartwheel);
        buster_x = (left_width / 2) + (950 * walk_facing);
        buster_y = 950;
        buster_hspd = -18;
        buster_vspd = -29;
        buster_grav = 0.6;
        event_pause(120);
    }, function()
    {
        screen_shake(10, 10, 0.28);
        event_pause(180);
    }, function()
    {
        launch = false;
        buster_hspd = 0;
        buster_vspd = 0;
        buster_grav = 0;
        buster_y = 1080;
        walk_facing = 1;
        cartwheel = false;
        event_buster_anim_walk();
        timeline[0]();
    }];
};

event_buster_anim_walkaway = function()
{
    event_buster_reset();
    timeline = [function()
    {
        walk_away = true;
        buster_facing = walk_facing;
        buster_play(spr_title_buster_walk);
        buster_x = left_width / 2;
        walk = true;
        
        if (global.first)
            wizard_rise = true;
        else
            wizard_rise = choose(true, false);
        
        var _xoff = 0;
        
        if (wizard_rise)
        {
            _xoff += 3000;
            timer[1] = 195;
        }
        
        buster_xto = (left_width / 2) + ((1800 + _xoff) * walk_facing);
    }];
};

timeline_pos = -1;
timeline = [];
pause = 0;
event_buster_reset();
buster_x -= 700;
walk_facing = 1;
walk_away = false;
wizard_rise = false;
wizard_yoff_max = sprite_get_height(spr_title_buster_wizard);
wizard_yoff = wizard_yoff_max;
wizard_percent = 1;
wizard_rise_anim = false;
timer[1] = -1;

timer_func[1] = function()
{
    var _rise = wizard_rise_anim;
    
    if (!_rise)
    {
        wizard_rise_anim = true;
        timer[1] = 300;
    }
    else
    {
        wizard_rise_anim = false;
    }
    
    wizard_percent = 0;
};

event_buster_animend = function()
{
    var _spr = buster_spr;
    
    if (_spr == spr_title_buster_smug_inb)
        buster_spr = spr_title_buster_smug;
    else if (_spr == spr_title_buster_smug_inb_out)
        buster_spr = spr_title_buster;
    else if (_spr == spr_title_buster_crazy_inb)
        buster_spr = spr_title_buster_crazy;
};

wizard_spr = spr_title_buster_wizard;
wizard_ind = 0;
timer[2] = -1;

timer_func[2] = function()
{
    box_in = true;
};

timer[4] = -1;

timer_func[4] = function()
{
    start_flash = !start_flash;
    timer[4] = start_flash_delay;
    
    if (box_in && !start_flash)
    {
        start_flash = false;
        timer[4] = -1;
    }
};

start_flash_delay = 8;
start_flash = true;
box_in = false;
box_x = 950;
box_percent = 0;
timer[3] = -1;

timer_func[3] = function()
{
    start_done = true;
    walk_facing = choose(1);
    event_buster_anim_walk();
};

bg_x = 0;
logo_scale = 1;
logo_x = 0;
logo_y = 0;
copyright_alpha = 1;

if (global.round_select)
{
    box_percent = 1;
    box_in = true;
    start_flash = false;
    event_buster_reset();
    start = true;
    start_done = true;
    instance_create_layer(0, 0, layer, obj_roundselect);
    timer[5] = 120;
}

if (global.theater != noone)
{
    box_percent = 1;
    box_in = true;
    start_flash = false;
    event_buster_reset();
    start = true;
    start_done = true;
    var _inst = instance_create_layer(0, 0, layer, obj_theater);
    _inst.selected = global.theater;
    timer[5] = 120;
}

logo_beat_percent = 1;
logo_scale_beat = 1;
beats = 0;
bpm = 100;
off_beat = 0;
logo_bounce_normal = 0.95;
logo_bounce_double = 0.9;
logo_bounce_amnt = logo_bounce_normal;

event_beat = function()
{
    if (!box_in)
        logo_beat_percent = 0;
    
    logo_bounce_amnt = logo_bounce_normal;
};

event_beat_double = function()
{
    logo_bounce_amnt = logo_bounce_double;
};

animations = [event_buster_anim_look, event_buster_anim_smug, event_buster_anim_crazy, event_buster_anim_zoomies, function()
{
    walk_facing = choose(-1, 1);
    event_buster_anim_walkaway();
}];
cycle_time = 300;
cycle_count = 0;
timer[5] = -1;

timer_func[5] = function()
{
    var _play = irandom_range(0, array_length(animations) - 1);
    
    if (global.first)
    {
        _play = cycle_count;
        cycle_count++;
        
        if (cycle_count > (array_length(animations) - 1))
        {
            global.first = false;
            cycle_count = 0;
        }
    }
    
    animations[_play]();
};
