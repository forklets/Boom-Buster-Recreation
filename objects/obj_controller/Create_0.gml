audio_sound_gain(snd_explosion, 1, 1500);
global.room_top = 64;
global.tutorial_trigger = 0;

if (room == rm_bonus_1 || room == rm_bonus_2 || room == rm_bonus_3 || room == rm_bonus_b1 || room == rm_bonus_b2 || room == rm_bonus_b3)
    global.playground = true;
else
    global.playground = false;

if (!global.round_select)
{
    if (room == rm_round_7_1 || room == rm_round_b7_1 || room == rm_round_14_1 || room == rm_round_b14_1 || room == rm_round_21_1 || room == rm_round_b21_1 || array_contains(global.bonus_rooms, room) || array_contains(global.stages_final_scroll, room))
    {
        with (obj_persistent)
            event_save();
    }
}

ps_rain = noone;

if (array_contains(global.stages_final_scroll, room))
{
    ps_rain = part_system_create();
    part_system_draw_order(ps_rain, true);
    var _ptype1 = part_type_create();
    part_type_shape(_ptype1, 3);
    part_type_size(_ptype1, 1, 1, 0, 0);
    part_type_scale(_ptype1, 1, 0.5);
    part_type_speed(_ptype1, 40, 40, 0, 0);
    part_type_direction(_ptype1, -110, -110, 0, 0);
    part_type_gravity(_ptype1, 0, 0);
    part_type_orientation(_ptype1, -110, -110, 0, 0, false);
    part_type_colour3(_ptype1, 16777215, 16777215, 16777215);
    part_type_alpha3(_ptype1, 0.157, 0.157, 0.157);
    part_type_blend(_ptype1, false);
    part_type_life(_ptype1, 45, 45);
    var _pemit1 = part_emitter_create(ps_rain);
    part_emitter_region(ps_rain, _pemit1, -750, 1750, -465, -465, 3, 0);
    part_emitter_stream(ps_rain, _pemit1, _ptype1, 1);
}

ps_lava = noone;

if (room == rm_final || room == rm_final_b)
{
    ps_lava = part_system_create();
    part_system_draw_order(ps_lava, true);
    var _ptype1 = part_type_create();
    part_type_shape(_ptype1, 8);
    part_type_size(_ptype1, 1.4, 1.9500000000000002, -0.012, 0);
    part_type_scale(_ptype1, 0.175, 0.175);
    part_type_speed(_ptype1, 2, 11, 0, 0);
    part_type_direction(_ptype1, 70, 110, 0, -1);
    part_type_gravity(_ptype1, 0.1, 270);
    part_type_orientation(_ptype1, 0, 0, 0, 12, false);
    part_type_colour3(_ptype1, 4474085, 2302898, 153);
    part_type_alpha3(_ptype1, 1, 1, 0.18);
    part_type_blend(_ptype1, false);
    part_type_life(_ptype1, 62, 100);
    var _pemit1 = part_emitter_create(ps_lava);
    part_emitter_region(ps_lava, _pemit1, -802, 798, -26.258606, 56.258606, 0, 1);
    part_emitter_stream(ps_lava, _pemit1, _ptype1, 11);
    part_emitter_interval(ps_lava, _pemit1, 0, 1, 0);
    part_system_position(ps_lava, room_width / 2, room_height);
}

stage_event = noone;
elements_completed_final = [];
blood_mask = noone;

if (!array_contains(global.stages_final, room) && !array_contains(global.stages_final_scroll, room))
    alarm[3] = 1;

if (layer_exists("Tiles_Grass_B") && !global.bside)
    layer_set_visible("Tiles_Grass_B", false);

var _footsteps = [obj_footstep_grass, obj_footstep_metal];
var _layers = layer_get_all();

for (var l = 0; l < array_length(_layers); l++)
{
    if (layer_get_name(_layers[l]) == "Tiles_Grass_B" && !global.bside)
        continue;
    
    var _tilemap = layer_tilemap_get_id(_layers[l]);
    
    if (_tilemap == -1)
        continue;
    
    var _tileset = tilemap_get_tileset(_tilemap);
    var _tileset_name = tileset_get_name(_tileset);
    
    if (!struct_exists(global.tile_data, _tileset_name))
        break;
    
    for (var xx = 0; xx < (room_width / 64); xx++)
    {
        for (var yy = 0; yy < (room_height / 64); yy++)
        {
            var _tile = tilemap_get(_tilemap, xx, yy);
            
            if (struct_exists(variable_struct_get(global.tile_data, _tileset_name), _tile))
            {
                var _get = struct_get(variable_struct_get(global.tile_data, _tileset_name), _tile);
                instance_create_layer(xx * 64, yy * 64, layer, _footsteps[_get]);
            }
        }
    }
}

for (var i = 0; i < array_length(_footsteps); i++)
{
    with (_footsteps[i])
        visible = false;
}

for (var i = 0; i < array_length(_layers); i++)
{
    var _tilemap = layer_tilemap_get_id(_layers[i]);
    
    if (_tilemap == -1)
        continue;
    
    var _tileset = tilemap_get_tileset(_tilemap);
    
    if (_tileset == tst_mall && global.bside)
        tilemap_tileset(_tilemap, tst_mall_b);
    
    if (_tileset == tst_city && global.bside)
        tilemap_tileset(_tilemap, tst_city_b);
    
    if (_tileset == tst_factory && global.bside && room != rm_final_scroll_b && room != rm_outskirts_b3)
        tilemap_tileset(_tilemap, tst_factory_b);
    
    if (_tileset == tst_tower && global.bside)
        tilemap_tileset(_tilemap, tst_tower_b);
}

if (global.last_room != room)
{
    global.hurt_remember = [];
    global.hurt_remember_players = [];
}

global.orb_round = 0;
global.coins_collected = 0;
global.food_got = false;
global.round = scr_get_round(room);
cam_free_x = false;
cam_free_y = false;
surf_gui = noone;
get_cams(0);
camx_last = camx;
alarm[2] = 1;
tv_override = false;
global.freeze = 0;

global.freeze_func = function()
{
};

global.hp = global.hpmax;
global.throw_boms = false;

if (array_contains(global.stages_final, room))
{
    global.bubble = false;
    global.combo_meter = 0;
    wizard_turned = false;
    wizard_waitshit = false;
}

global.died = false;
global.dollars_start = global.dollars;
global.combo_meter_start = global.combo_meter;
global.onoff = 0;
global.onoff_max = 1;
global.onoff_min = 0;
global.onoff_colors = [0, 1, 2, 3, 4];

if (global.invincible)
    global.invincible = false;

combo_meter_lerp = global.combo_meter;
hp_spr = spr_ui_hp0;
global.goodnight = false;
goodnight = false;
flash_overlay = false;
pattern_x = 0;
pattern_y = 0;

if (layer_exists(layer_get_id("Collision")))
    layer_set_visible(layer_get_id("Collision"), false);

if (layer_exists(layer_get_id("Pipes")))
    layer_set_visible(layer_get_id("Pipes"), true);

if (layer_exists(layer_get_id("Terrain")))
    layer_set_visible(layer_get_id("Terrain"), true);

if (layer_exists(layer_get_id("Instances")))
    layer_set_visible(layer_get_id("Instances"), true);

if (layer_exists(layer_get_id("Instances_Behind")))
    layer_set_visible(layer_get_id("Instances_Behind"), true);

if (layer_exists(layer_get_id("Instances_Over")))
    layer_set_visible(layer_get_id("Instances_Over"), true);

if (layer_exists(layer_get_id("Player")))
    layer_set_visible(layer_get_id("Player"), true);

display_highscore = true;

if (global.stage == 7)
    display_highscore = false;

bossfight = false;
stage_event = noone;
timer_dollars_flash = 0;
timer_bridget = 1;
timer_bridget_finish = 2;
timer_win = 3;
timer_channel = 4;
timer_hey = 5;
timer_meter_icon_flash = 6;
timer_cam_go = 7;
timer_clear = 8;
timer[timer_dollars_flash] = -1;

timer_func[timer_dollars_flash] = function()
{
    dollars_flash = !dollars_flash;
    timer[timer_dollars_flash] = 4;
};

timer[timer_win] = -1;

timer_func[timer_win] = function()
{
    var _room, _file;
    
    if (room == global.stages_tutorial[array_length(global.stages_tutorial) - 1])
    {
        if (global.bside)
            _room = rm_round_b1;
        else
            _room = rm_round_1;
        
        var _str = room_get_name(_room);
        _file = $"stages/{directory_get(global.bside)}/{_str}.json";
    }
    else if (array_contains(global.stages_final, room))
    {
        _room = rm_cutscene_ending;
    }
    else
    {
        var _tutorial = false;
        var _stages;
        
        if (array_contains(global.stages_tutorial, room))
        {
            _stages = global.stages_tutorial;
            _tutorial = true;
        }
        else
        {
            _stages = global.stages;
        }
        
        var _str;
        
        for (var i = 0; i < array_length(_stages); i++)
        {
            if (_tutorial)
            {
                if (room == _stages[i])
                {
                    _str = room_get_name(_stages[i + 1]);
                    break;
                }
            }
            else if (room == _stages[i][global.bside])
            {
                _str = room_get_name(_stages[i + 1][global.bside]);
                break;
            }
        }
        
        _file = $"stages/{directory_get(global.bside)}/{_str}.json";
        _room = asset_get_index(_str);
    }
    
    var _cutscene = undefined;
    
    if (room == rm_bonus_1 || room == rm_bonus_b1)
        _cutscene = rm_cutscene_city;
    else if (room == rm_bonus_2)
        _cutscene = rm_cutscene_mall;
    else if (room == rm_bonus_3)
        _cutscene = rm_cutscene_factory;
    else if (array_contains(global.stages_final, room))
        _cutscene = rm_cutscene_ending;
    
    var _delay = 45;
    
    if (_cutscene || _room == rm_bonus_1 || _room == rm_bonus_b1 || _room == rm_bonus_2 || _room == rm_bonus_b2 || _room == rm_bonus_3 || _room == rm_bonus_b3)
    {
        if (_cutscene)
            _delay = 180;
        else
            _delay = 300;
        
        with (obj_bonus_controller)
            audio_sound_gain(bgm_play, 0, 1500);
        
        audio_sound_gain(global.bgmPlay, 0, 1500);
        
        if (_cutscene)
            _room = _cutscene;
    }
    
    if (room == global.stages_tutorial[array_length(global.stages_tutorial) - 1])
    {
        _room = rm_round_1;
        _delay = 120;
        audio_sound_gain(global.bgmPlay, 0, 1500);
    }
    
    if (room_exists(_room))
    {
        global.stage_load = _file;
        audio_sound_gain(snd_explosion, 0, 1500);
        
        if (array_contains(global.stages_final_scroll, room))
            _room = rm_gotime;
        
        if (room == rm_outskirts_3 || room == rm_outskirts_b3)
            _delay = 180;
        
        var _trans = room_goto_triangles(_room, _delay);
        
        _trans.func_roomend = function()
        {
            part_particles_clear(global.part_behind);
            part_particles_clear(global.part_gui);
            part_particles_clear(global.part_over);
            part_particles_clear(global.part_over_nostun);
            
            if (audio_is_playing(snd_explosion))
                audio_stop_sound(snd_explosion);
            
            audio_sound_gain(snd_explosion, 1, 0);
        };
        
        if (stage_event == "wizard" && !instance_exists(obj_round_clear))
        {
            _trans.col = 16777215;
            _trans.wait = 60;
        }
    }
    else
    {
        audio_sound_gain(global.bgmPlay, 0, 1200);
        var _trans;
        
        if (stage_event == "wizard")
            _trans = room_goto_triangles(rm_nothing, 30);
        else
            _trans = room_goto_triangles(rm_results, 60);
        
        _trans.func_roomend = function()
        {
            part_particles_clear(global.part_behind);
            part_particles_clear(global.part_gui);
            part_particles_clear(global.part_over);
            part_particles_clear(global.part_over_nostun);
            audio_stop_all();
        };
    }
};

timer[timer_clear] = -1;

timer_func[timer_clear] = function()
{
    instance_create_layer(0, 0, layer, obj_round_clear);
};

timer[timer_hey] = 8;

timer_func[timer_hey] = function()
{
    hey_ind = !hey_ind;
    timer[timer_hey] = 8;
};

hey_ind = 0;
timer[timer_meter_icon_flash] = -1;

timer_func[timer_meter_icon_flash] = function()
{
    meter_icon_flash = !meter_icon_flash;
};

meter_icon_flash = false;
bridget_state_dig = 0;
bridget_state_pull = 1;
bridget_state_react = 2;
bridget_state_wind = 3;
bridget_state_toss = 4;
bridget_state_done = 5;
bridget_state_brb = 6;
bridget_state = bridget_state_dig;
win = false;
wizard_win = false;
static_ind = 0;
scr_tv_create_bridget();
scr_tv_create_wizard();
stage_setup();
global.food[global.act] = false;
alarm[0] = 2;
global.boss_hp = -4;
var _past_act_1;

if (array_contains(global.wizard_events_total, room))
{
    _past_act_1 = false;
    
    for (var i = 0; i < array_length(global.wizard_events); i++)
    {
        for (var j = 0; j < array_length(global.wizard_events[i][global.bside]); j++)
        {
            if (room == global.wizard_events[i][global.bside][j])
            {
                global.boss_hp = 3 - j;
                
                if (j > 0)
                    _past_act_1 = true;
                
                break;
            }
        }
    }
}

if (array_contains(global.bonus_rooms, room))
{
    instance_create_layer(0, 0, "Transition", obj_stagestart_bonus);
}
else if (global.last_room == room)
{
    var _trans = instance_create_layer(0, 0, "Transition", obj_transition_fade);
    
    with (_trans)
    {
        fade_alpha = 1;
        state = 1;
        col = 16777215;
    }
}
else if (((stage_event == "wizard" && _past_act_1) || array_contains(global.stages_final, room)) && !array_contains(global.stages_outskirts, room))
{
    var _trans = instance_create_layer(0, 0, "Transition", obj_transition_fade);
    
    with (_trans)
    {
        fade_alpha = 1;
        state = 1;
        col = 16777215;
    }
}
else
{
    instance_create_layer(0, 0, "Transition", obj_stagestart);
}

tv_bg_ind = 0;
fps_caption_timer = 5;
asset_obj[0][0] = "obj_bom";
asset_obj[0][1] = "obj_bom";
asset_obj[0][2] = "obj_bom";
asset_obj[0][3] = "obj_bom";
asset_obj[0][4] = "obj_bom";
asset_obj[0][5] = "obj_bom";
asset_obj[0][6] = "obj_bom";
asset_obj[1][0] = "obj_dynalife";
asset_obj[1][1] = "obj_barrel";
asset_obj[2][0] = "obj_coin";
asset_obj[2][1] = "obj_food";
asset_obj[2][2] = "obj_crate";
asset_obj[2][3] = "obj_crate_64";
asset_obj[2][4] = "obj_crate_128";
asset_obj[2][5] = "obj_itemcrate";
asset_obj[2][6] = "obj_gem";
asset_obj[2][7] = "obj_key";
asset_obj[3][0] = "obj_lip";
asset_obj[3][1] = "obj_ball";
asset_obj[3][2] = "obj_goblinjr";
asset_obj[3][3] = "obj_rodger";
asset_obj[3][4] = "obj_ritz";
asset_obj[3][5] = "obj_hissy";
asset_obj[3][6] = "obj_hamster";
asset_obj[3][7] = "obj_ball_fly";
asset_obj[3][8] = "obj_pinky";
asset_obj[3][9] = "obj_scarab";
asset_obj[4][0] = "tv event";
asset_obj[4][1] = "bridget event";
asset_obj[4][2] = "wizard event";
asset_obj[5][0] = "obj_lightning";
asset_obj[5][1] = "obj_lightsout";
asset_obj[5][2] = "obj_fireball";
asset_obj[5][3] = "obj_knife_indicator";
asset_obj[6][0] = "play sound";
asset_obj[6][1] = "pause";
asset_obj[7][0] = "obj_bom_rainbow";
asset_obj[7][1] = "obj_bom_swap";
asset_obj[7][2] = "obj_bom_anxious";
follow_target = true;
myX = x;
myY = y;
instance_create_depth(0, 0, layer_get_depth(layer_get_id("Player")) - 1, obj_shaders_instances);
instance_create_depth(0, 0, layer_get_depth(layer_get_id("Particles_Behind")) - 1, obj_shaders_particles_behind);
var _editor = instance_create_layer(0, 0, layer, obj_editor);
_editor.depth = layer_get_depth(layer) - 1;
zoom = 1;

if (room == rm_outskirts_3 || room == rm_outskirts_b3)
    zoom = 1.1;

cam_stretch = false;
cam_xoff = 0;
cam_yoff = 0;
relative_position = -4;
relative_pos_ease = 1;
barrier_move = 0;
cam_dir = 1;
move_percent = 0;
boms_left = boms_total;
bombfuse_ind = 0;
anim_bombfuse = 0;
boms_leftOffset = 0;
boms_leftUI = boms_left;
spark_pos = 0;
spark_posTo = spark_pos;
hp_ind = 0;
target = obj_player;
target_swap = 0;

if (instance_exists(obj_cambarrierL))
    barrierL = obj_cambarrierL.x;
else
    barrierL = 64;

if (instance_exists(obj_cambarrierR))
    barrierR = obj_cambarrierR.x;
else
    barrierR = room_width - 64;

if (instance_exists(obj_cambarrierU))
    barrierU = obj_cambarrierU.y;
else
    barrierU = 64;

if (instance_exists(obj_cambarrierD))
    barrierD = obj_cambarrierD.y;
else
    barrierD = room_height - 64;

global.hurt = noone;
channel = 1;
tv_script[0] = asset_get_index("scr_tv_static");
tv_script[1] = asset_get_index("scr_tv_bridget");
tv_script[2] = asset_get_index("scr_tv_wizard");
timer[timer_channel] = -1;

timer_func[timer_channel] = function()
{
    channel = channel_next;
};

channel_change = function(arg0, arg1 = 25)
{
    timer[timer_channel] = arg1;
    channel = 0;
    channel_next = arg0;
};

dollars = global.dollars;
dollars_flash = false;

draw_dollars = function()
{
    scr_draw_dollars();
};

draw_bombcounter = function()
{
    var _bombX = 1478;
    var _bombY = 294;
    draw_sprite_gui(spr_ui_bomb, 0, _bombX, _bombY);
    var _pos = spark_pos;
    var _x = path_get_x(pth_gui_bombfuse, _pos);
    var _y = path_get_y(pth_gui_bombfuse, _pos);
    
    if (room == rm_tutorial_7)
    {
    }
    else if (spark_pos >= 1)
    {
    }
    else
    {
        draw_sprite_gui(spr_ui_bomb_fuse, spark_pos * sprite_get_number(spr_ui_bomb_fuse), _bombX, _bombY);
        draw_sprite_gui(spr_ui_bombSpark, bombfuse_ind, _x, _y);
    }
    
    _x = 42;
    _y = 424;
    
    if (string_length(string(boms_left)) == 1)
    {
        var _shakex, _shakey;
        
        if (exit_freeze())
        {
            _shakex = 0;
            _shakey = 0;
        }
        else
        {
            _shakex = irandom_range(-boms_leftOffset, boms_leftOffset);
            _shakey = irandom_range(-boms_leftOffset, boms_leftOffset);
        }
        
        draw_set_font(obj_persistent.font_bombmiddle);
        
        if (room != rm_tutorial_7)
            draw_text(1436 + global.app_xoff + 50 + _shakex, _y + _shakey, string(boms_left));
    }
    else
    {
        var _shakex, _shakey;
        
        if (exit_freeze())
        {
            _shakex = 0;
            _shakey = 0;
        }
        else
        {
            _shakex = irandom_range(-boms_leftOffset, boms_leftOffset);
            _shakey = irandom_range(-boms_leftOffset, boms_leftOffset);
        }
        
        draw_set_font(obj_persistent.font_bombleft);
        
        if (room != rm_tutorial_7)
            draw_text(1436 + global.app_xoff + _x + _shakex + 6, _y + _shakey, string_char_at(string(boms_left), 1));
        
        if (exit_freeze())
        {
            _shakex = 0;
            _shakey = 0;
        }
        else
        {
            _shakex = irandom_range(-boms_leftOffset, boms_leftOffset);
            _shakey = irandom_range(-boms_leftOffset, boms_leftOffset);
        }
        
        draw_set_font(obj_persistent.font_bombright);
        
        if (room != rm_tutorial_7)
            draw_text(1512 + global.app_xoff + _x + _shakex + 2, _y + 8 + _shakey, string_char_at(string(boms_left), 2));
        
        draw_sprite_gui(spr_ui_bomb, 1, _bombX, _bombY);
    }
};

global.food[global.act - 1] = false;

draw_wizardui = function()
{
    var _spr = spr_ui_bosshp;
    
    if (array_contains(global.stages_outskirts, room))
        _spr = spr_ui_bosshp_tower;
    else
        _spr = spr_ui_bosshp;
    
    var _ind;
    
    if (array_contains(global.stages_final, room) || array_contains(global.stages_final_scroll, room))
        _ind = 2;
    else
        _ind = 3 - global.boss_hp;
    
    if (instance_exists(obj_final_blow))
        _ind = 3;
    
    draw_sprite_gui(_spr, _ind, 1398, 915);
    global.combo_meter = 0;
};

draw_combometer_icon = function()
{
    var _x = 1765;
    var _y = 928;
    draw_sprite_gui(spr_ui_meter_icon, 0, _x, _y);
    draw_sprite_gui(spr_ui_meter_icon, 1, _x, _y);
    
    if (meter_icon_flash)
        draw_sprite_gui_ext(spr_ui_meter_icon, 2, _x, _y, 1, 1, 0, 16777215, 0.1);
};

draw_combometer = function()
{
    if (global.combo_meter < global.combo_meter_max)
    {
        timer[timer_meter_icon_flash] = -1;
        meter_icon_flash = false;
    }
    else if (timer[timer_meter_icon_flash] == -1)
    {
        timer[timer_meter_icon_flash] = 6;
    }
    
    var _spr = spr_ui_meter;
    var _x = 1433;
    var _y = 950;
    var _left = 0;
    var _top = 0;
    var _width = sprite_get_width(_spr);
    var _fill = global.combo_meter / global.combo_meter_max;
    var _height = sprite_get_height(_spr);
    var _col = 32567;
    draw_sprite_part_ext(_spr, 0, _left, _top, _width, _height, _x, _y, 1, 1, _col, 1);
    _col = 16777215;
    draw_sprite_part_ext(_spr, 1, _left, _top, _width * _fill, _height, _x, _y, 1, 1, _col, 1);
    draw_sprite(spr_ui_meter_overlay, 0, _x + 2, _y + 3);
    
    if (meter_icon_flash)
        draw_sprite_part_ext(_spr, 0, _left, _top, _width, _height, _x, _y, 1, 1, c_white, 0.1);
};

draw_hp = function()
{
    var _shake = 0;
    draw_sprite_gui(hp_spr, hp_ind, 1458 + (_shake * irandom_range(-3, 3)), 492 + (_shake * irandom_range(-3, 3)));
};

draw_bossui = function()
{
    var _x = 1444 + global.app_xoff;
    var _y = 840;
    draw_set_color(#A50000);
    draw_rectangle(_x, _y, _x + 440, _y + 69, false);
    draw_set_color(#8CEF13);
    draw_rectangle(_x, _y, _x + (440 * (global.boss_hp / global.boss_hpmax)), _y + 69, false);
    draw_set_color(c_white);
    draw_set_font(fnt_splatter_55);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(_x + 220, _y + 34.5, global.boss_hp);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
};

var _bg = instance_create_layer(0, 0, "BG", obj_bg);
view_surf = noone;
timer[timer_cam_go] = -1;

timer_func[timer_cam_go] = function()
{
    cam_go = true;
};

if (array_contains(global.stages_final, room))
{
    y = room_height - 1080;
    cam_go = false;
    timer[timer_cam_go] = 30;
    cam_spd = 0;
    cam_final_yoff = 0;
    cam_final = false;
    final_ended = false;
}

final_ready = false;
jello_bounced = false;
cam_final_vspd = 0;

event_final_jello = function()
{
    if (jello_bounced)
        exit;
    
    jello_bounced = true;
    cam_final_vspd = -10;
};
