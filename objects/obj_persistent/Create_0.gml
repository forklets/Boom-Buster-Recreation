audio_sound_gain(voice_wizard_icantbelieve, 1.7, 0);
audio_sound_gain(voice_wizard_myhistory, 1.7, 0);
audio_sound_gain(voice_wizard_imsupposed, 1.7, 0);
audio_sound_gain(voice_wizard_thisstorywas, 1.7, 0);
audio_sound_gain(voice_wizard_iwaseatingright, 1.7, 0);
audio_sound_gain(voice_wizard_yourejustalittlepunk, 1.7, 0);
audio_sound_gain(voice_wizard_suicidenote, 1.95, 0);
audio_sound_gain(voice_wizard_ifigotevicted, 1.75, 0);
audio_sound_gain(voice_wizard_screamno, 1.6, 0);
audio_sound_gain(voice_wizard_wait, 3.3, 0);
audio_sound_gain(voice_wizard_wait_shit, 2.8, 0);
audio_sound_gain(voice_wizard_pain0, 1.5, 0);
audio_sound_gain(voice_wizard_pain1, 1.5, 0);
audio_sound_gain(voice_wizard_pain2, 1.5, 0);
audio_sound_gain(voice_wizard_pain3, 1.5, 0);
audio_sound_gain(voice_wizard_pain4, 1.5, 0);
audio_sound_gain(voice_wizard_pain5, 1.5, 0);
audio_sound_gain(voice_wizard_pain6, 1.5, 0);
audio_sound_gain(voice_bridget_dammit0, 1.4, 0);
audio_sound_gain(voice_bridget_dammit1, 1.4, 0);
audio_sound_gain(voice_bridget_ohok, 1.4, 0);
audio_sound_gain(voice_bridget_sorryidied, 1.16, 0);
audio_sound_gain(snd_jump, 1.35, 0);
audio_sound_gain(snd_spin, 1.35, 0);
audio_sound_gain(snd_dash, 1.2, 0);
audio_sound_gain(snd_skid, 1.19, 0);
audio_sound_gain(snd_revenge, 1.5, 0);
audio_sound_gain(bgm_outskirts, 0.95, 0);
audio_sound_gain(bgm_city, 1.35, 0);
audio_sound_gain(bgm_grotto, 1.5, 0);
var _gain = 1.22;
audio_sound_gain(snd_footstep_concrete0, _gain, 0);
audio_sound_gain(snd_footstep_concrete1, _gain, 0);
audio_sound_gain(snd_footstep_concrete2, _gain, 0);
audio_sound_gain(snd_footstep_concrete3, _gain, 0);
audio_sound_gain(snd_footstep_concrete4, _gain, 0);
audio_sound_gain(snd_footstep_grass0, _gain, 0);
audio_sound_gain(snd_footstep_grass1, _gain, 0);
audio_sound_gain(snd_footstep_grass2, _gain, 0);
audio_sound_gain(snd_footstep_grass3, _gain, 0);
audio_sound_gain(snd_footstep_metal0, _gain, 0);
audio_sound_gain(snd_footstep_metal1, _gain, 0);
audio_sound_gain(snd_footstep_metal2, _gain, 0);
audio_sound_gain(snd_footstep_metal3, _gain, 0);
audio_sound_gain(snd_footstep_metal4, _gain, 0);
global.key_names = {};

var setKeyName = function(arg0, arg1)
{
    struct_set(global.key_names, arg0, arg1);
};

setKeyName(27, "Escape");
setKeyName(32, "Space");
setKeyName(13, "Enter");
setKeyName(37, "Arrow Left");
setKeyName(39, "Arrow Right");
setKeyName(38, "Arrow Up");
setKeyName(40, "Arrow Down");
setKeyName(8, "Backspace");
setKeyName(9, "Tab");
setKeyName(16, "Shift");
setKeyName(17, "Control");
setKeyName(18, "Alt");
setKeyName(19, "Pause");
setKeyName(20, "Capslock");
setKeyName(160, "LeftShift");
setKeyName(161, "RightShift");
setKeyName(162, "LeftControl");
setKeyName(163, "RightControl");
setKeyName(164, "LeftAlt");
setKeyName(165, "RightAlt");
setKeyName(91, "Windows");
setKeyName(92, "RightWindows");
setKeyName(33, "PageUp");
setKeyName(34, "PageDown");
setKeyName(35, "End");
setKeyName(36, "Home");
setKeyName(44, "PrintScreen");
setKeyName(45, "Insert");
setKeyName(46, "Delete");
setKeyName(145, "ScrollLock");
setKeyName(186, "Semicolon");
setKeyName(187, "Equals");
setKeyName(188, "Comma");
setKeyName(189, "Underscore");
setKeyName(190, "Period");
setKeyName(191, "Slash");
setKeyName(192, "Tilde");
setKeyName(219, "OpenBracket");
setKeyName(220, "BackSlash");
setKeyName(221, "CloseBracket");
setKeyName(222, "Quote");
setKeyName(65, "A");
setKeyName(66, "B");
setKeyName(67, "C");
setKeyName(68, "D");
setKeyName(69, "E");
setKeyName(70, "F");
setKeyName(71, "G");
setKeyName(72, "H");
setKeyName(73, "I");
setKeyName(74, "J");
setKeyName(75, "K");
setKeyName(76, "L");
setKeyName(77, "M");
setKeyName(78, "N");
setKeyName(79, "O");
setKeyName(80, "P");
setKeyName(81, "Q");
setKeyName(82, "R");
setKeyName(83, "S");
setKeyName(84, "T");
setKeyName(85, "U");
setKeyName(86, "V");
setKeyName(87, "W");
setKeyName(88, "X");
setKeyName(89, "Y");
setKeyName(90, "Z");
setKeyName(48, "0");
setKeyName(49, "1");
setKeyName(50, "2");
setKeyName(51, "3");
setKeyName(52, "4");
setKeyName(53, "5");
setKeyName(54, "6");
setKeyName(55, "7");
setKeyName(56, "8");
setKeyName(57, "9");
setKeyName(112, "F1");
setKeyName(113, "F2");
setKeyName(114, "F3");
setKeyName(115, "F4");
setKeyName(116, "F5");
setKeyName(117, "F6");
setKeyName(118, "F7");
setKeyName(119, "F8");
setKeyName(120, "F9");
setKeyName(121, "F10");
setKeyName(122, "F11");
setKeyName(123, "F12");
setKeyName(124, "F13");
setKeyName(125, "F14");
setKeyName(126, "F15");
setKeyName(127, "F16");
setKeyName(128, "F17");
setKeyName(129, "F18");
setKeyName(130, "F19");
setKeyName(131, "F20");
setKeyName(132, "F21");
setKeyName(133, "F22");
setKeyName(134, "F23");
setKeyName(135, "F24");
setKeyName(144, "Numlock");
setKeyName(111, "Divide");
setKeyName(106, "Multiply");
setKeyName(107, "Add");
setKeyName(109, "Subtract");
setKeyName(110, "NumpadDelete");
setKeyName(96, "Numpad0");
setKeyName(97, "Numpad1");
setKeyName(98, "Numpad2");
setKeyName(99, "Numpad3");
setKeyName(100, "Numpad4");
setKeyName(101, "Numpad5");
setKeyName(102, "Numpad6");
setKeyName(103, "Numpad7");
setKeyName(104, "Numpad8");
setKeyName(105, "Numpad9");
texture_prefetch("tg_title");
texture_prefetch("tg_bg_city");
texture_prefetch("tg_mall");
texture_prefetch("tg_bg_factory");
texture_prefetch("tg_bg_outskirts");
texture_prefetch("tg_bg_bonus");
texture_prefetch("tg_ui_common");
texture_prefetch("fonts");
global.round_select = false;
global.round_select_menu = 0;
global.round_select_selected = 0;
global.theater = noone;
global.pause_buster_data = load_json("ghost_pause.json").ghost;
sprite_set_offset(spr_crate_64, 0, 64);
sprite_set_offset(spr_crate_96, 0, 96);
sprite_set_offset(spr_crate_128, 0, 128);
sprite_set_offset(spr_bricks_96, 0, 96);
sprite_set_offset(spr_bricks_128, 0, 128);
sprite_set_offset(spr_metal_128, 0, 128);
global.ball_clean = true;
global.last_highscore_name = "AAA";
global.hurt_remember = [];
global.hurt_remember_players = [];
global.bside = false;
global.last_room = room;
global.round_quotas = 
{
    rm_round_1: 72
};
global.stages_tutorial = [rm_tutorial_1, rm_tutorial_2, rm_tutorial_3, rm_tutorial_4, rm_tutorial_5, rm_tutorial_6, rm_tutorial_7];
global.stages = [[rm_round_1, rm_round_b1], [rm_round_2, rm_round_b2], [rm_round_3, rm_round_b3], [rm_round_4, rm_round_b4], [rm_round_5, rm_round_b5], [rm_round_6, rm_round_b6], [rm_round_7_1, rm_round_b7_1], [rm_round_7_2, rm_round_b7_2], [rm_round_7_3, rm_round_b7_3], [rm_bonus_1, rm_bonus_b1], [rm_round_8, rm_round_b8], [rm_round_9, rm_round_b9], [rm_round_10, rm_round_b10], [rm_mall_extra1, rm_mall_extrab1], [rm_round_11, rm_round_b11], [rm_round_12, rm_round_b12], [rm_round_13, rm_round_b13], [rm_round_14_1, rm_round_b14_1], [rm_round_14_2, rm_round_b14_2], [rm_round_14_3, rm_round_b14_3], [rm_bonus_2, rm_bonus_b2], [rm_round_15, rm_round_b15], [rm_round_16, rm_round_b16], [rm_round_17, rm_round_b17], [rm_round_18, rm_round_b18], [rm_factory_extra1, rm_factory_extrab1], [rm_round_19, rm_round_b19], [rm_round_20, rm_round_b20], [rm_round_21_1, rm_round_b21_1], [rm_round_21_2, rm_round_b21_2], [rm_round_21_3, rm_round_b21_3], [rm_bonus_3, rm_bonus_b3], [rm_outskirts_1, rm_outskirts_b1], [rm_outskirts_2, rm_outskirts_b2], [rm_outskirts_3, rm_outskirts_b3], [rm_final_scroll, rm_final_scroll_b], [rm_final, rm_final_b]];
global.bonus_rooms = [rm_bonus_1, rm_bonus_b1, rm_bonus_2, rm_bonus_b2, rm_bonus_3, rm_bonus_b3];
global.stages_outskirts = [rm_outskirts_1, rm_outskirts_2, rm_outskirts_3, rm_outskirts_b1, rm_outskirts_b2, rm_outskirts_b3];
global.wizard_events[0][0] = [rm_round_7_1, rm_round_7_2, rm_round_7_3];
global.wizard_events[0][1] = [rm_round_b7_1, rm_round_b7_2, rm_round_b7_3];
global.wizard_events[1][0] = [rm_round_14_1, rm_round_14_2, rm_round_14_3];
global.wizard_events[1][1] = [rm_round_b14_1, rm_round_b14_2, rm_round_b14_3];
global.wizard_events[2][0] = [rm_round_21_1, rm_round_21_2, rm_round_21_3];
global.wizard_events[2][1] = [rm_round_b21_1, rm_round_b21_2, rm_round_b21_3];
global.wizard_events[3][0] = [rm_outskirts_1, rm_outskirts_2, rm_outskirts_3];
global.wizard_events[3][1] = [rm_outskirts_b1, rm_outskirts_b2, rm_outskirts_b3];
global.wizard_events_total = [];

for (var i = 0; i < 2; i++)
{
    for (var j = 0; j < array_length(global.wizard_events); j++)
    {
        var _event = global.wizard_events[j][i];
        
        for (var c = 0; c < array_length(_event); c++)
        {
            var _me = _event[c];
            
            if (!array_contains(global.wizard_events_total, _me))
                array_push(global.wizard_events_total, _me);
        }
    }
}

global.stages_final = [rm_final, rm_final_b];
global.stages_final_scroll = [rm_final_scroll, rm_final_scroll_b];
global.cutscene_rooms = [rm_cutscene_opening, rm_cutscene_city, rm_cutscene_mall, rm_cutscene_factory, rm_cutscene_ending];
global.dabom = 
{
    rm_round_1: 100,
    rm_round_2: 100,
    rm_round_3: 100
};
audio_sound_loop_start(bgm_city, 23.458);
audio_sound_loop_start(bgm_mall, 25.6);
audio_sound_loop_start(bgm_mall_b, 45.436);
audio_sound_loop_start(bgm_factory, 7.8);
audio_sound_loop_start(bgm_factory_b, 6.19);
audio_sound_loop_end(bgm_factory_b, 142.45);
audio_sound_loop_start(bgm_city_b, 2.28);
audio_sound_loop_start(bgm_grotto, 0);
audio_sound_loop_end(bgm_grotto, 184.806);
audio_sound_loop_start(bgm_outskirts, 22.09);
audio_sound_loop_start(bgm_boss, 14.435);
audio_sound_loop_start(bgm_title, 19.2);
audio_sound_loop_start(bgm_cutscene_spooky, 8.27);

for (var i = 0; i < 2; i++)
    global.palette[i] = 0;

global.opening = true;
global.level_select = 0;
var _loading = instance_create_layer(0, 0, layer, obj_loading);
_loading.audio_groups_load = [bgm_bonus];

_loading.event_done = function()
{
    room_goto(rm_tileset_setup);
};

global.performance = false;
global.debug = true;
global.bgmPlay = noone;
global.stage = 1;
global.act = 1;
global.achievements = 
{
    DIE: 
    {
        name: "Die",
        desc: "Die in the video game (not in real life)"
    },
    TOWER_1: 
    {
        name: "no name",
        desc: "Destroy the First Wizard Tower."
    },
    TOWER_2: 
    {
        name: "no name",
        desc: "Destroy the Second Wizard Tower."
    },
    TOWER_3: 
    {
        name: "no name",
        desc: "Destroy the Third Wizard Tower."
    },
    OUTSKIRTS: 
    {
        name: "The Outskirts",
        desc: "Defeat the Outskirts."
    },
    THE_END: 
    {
        name: "The End",
        desc: "Demolish the Wizard."
    },
    TOWER_1B: 
    {
        name: "no name",
        desc: "Destroy the First Wizard Tower in B-Side."
    },
    TOWER_2B: 
    {
        name: "no name",
        desc: "Destroy the Second Wizard Tower in B-Side."
    },
    TOWER_3B: 
    {
        name: "no name",
        desc: "Destroy the Third Wizard Tower in B-Side."
    },
    OUTSKIRTS_B: 
    {
        name: "The Outskirts",
        desc: "Defeat the Outskirts in the Wizard's Revenge."
    },
    THE_END_B: 
    {
        name: "no name",
        desc: "Demolish the Wizard in the Wizard's Revenge."
    },
    FOOD: 
    {
        name: "no name",
        desc: "Collect every food."
    },
    FOOD_B: 
    {
        name: "no name",
        desc: "Collect every food."
    },
    BUZZSAW: 
    {
        name: "no name",
        desc: "Paint a buzzsaw completely red. Blegh."
    },
    LIGHTNING: 
    {
        name: "no name",
        desc: "Get struck by lightning. Some say it's lucky."
    },
    WIZARD_BRIDGET: 
    {
        name: "no name",
        desc: "Demolish the Wizard as Bridget."
    },
    WIN_DEATH_30: 
    {
        name: "no name",
        desc: "Complete a run in under 30 deaths."
    },
    WIN_DEATH_15: 
    {
        name: "no name",
        desc: "Complete a run in under 15 deaths."
    },
    WIN_DEATH_5: 
    {
        name: "no name",
        desc: "Complete a run in under 5 deaths."
    },
    WIN_DEATH_0: 
    {
        name: "no name",
        desc: "Complete a run without dying once.",
        secret: true
    },
    COMBO_5: 
    {
        name: "no name",
        desc: "Get a 5x combo."
    },
    COMBO_7: 
    {
        name: "no name",
        desc: "Get a 7x combo."
    },
    DUD: 
    {
        name: "Dud Baby",
        desc: "Kill the dud baby."
    },
    FIRE: 
    {
        name: "Fire, Baby!",
        desc: "Get set on fire."
    },
    BONUS_1: 
    {
        name: "Bonus Points",
        desc: "Perfect Bonus Room I"
    },
    BONUS_2: 
    {
        name: "I'm Gonna Wreck It",
        desc: "Perfect Bonus Room II"
    },
    BONUS_3: 
    {
        name: "Hammer Time",
        desc: "Perfect Bonus Room III"
    },
    BONUS_1B: 
    {
        name: "Super Bonus Points",
        desc: "Perfect Bonus Room I (B-Side)"
    },
    BONUS_2B: 
    {
        name: "1-UP! Power Up!",
        desc: "Perfect Bonus Room II (B-Side)"
    },
    BONUS_3B: 
    {
        name: "How Am I Running So Fast?",
        desc: "Perfect Bonus Room III (B-Side)"
    },
    BOOM_BUSTER: 
    {
        name: "BOOM! Buster",
        desc: "Get every single achievement."
    }
};
ini_open("achievements.ini");
struct_foreach(global.achievements, function(arg0, arg1)
{
    if (!struct_exists(variable_struct_get(global.achievements, arg0), "secret"))
        variable_struct_get(global.achievements, arg0).secret = false;
    
    variable_struct_get(global.achievements, arg0).got = ini_read_real("ACHIEVEMENTS", arg0, false);
});
ini_close();
global.app_xoff = 0;
str[0] = "left";
str[1] = "right";
str[2] = "up";
str[3] = "down";
str[4] = "jump";
str[5] = "spin";
str[6] = "dash";
str[7] = "crouch";
str[8] = "drop";
str[9] = "start";
str[10] = "select";
global.world = 1;
font_dollars = font_add_sprite_ext(spr_font_dollars, "$.0123456789", true, 0);
font_coins = font_add_sprite_ext(spr_font_coin, "$.0123456789", true, 0);
font_alarm = font_add_sprite_ext(spr_font_alarm, "0123456789.-", false, 7);
var _mapstring = string("ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789,.!?/:{0}{1}'()*-$%[]<>+", "\"", "");
font_main = font_add_sprite_ext(spr_font_main, _mapstring, true, 0);
font_bombleft = font_add_sprite_ext(spr_font_bombLeft, "987654321", true, 0);
font_bombmiddle = font_add_sprite_ext(spr_font_bombMiddle, "9876543210", false, 0);
font_bombright = font_add_sprite_ext(spr_font_bombRight, "9876543210", true, 0);
font_controls = font_add_sprite_ext(spr_font_keys, "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-+←→↑↓", false, 0);
font_pixel = font_add_sprite_ext(spr_font_pixel, "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!?.,\"'$%:<()&-/*", true, 2);
font_pixel_outline = font_add_sprite_ext(spr_font_pixel_outline, "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!?.,\"'$%:<()&-/*", true, -1);
font_pixel_gradient = font_add_sprite_ext(spr_font_pixel_gradient, "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!?.,\"'$%:<()&-/*", false, 2);
font_pixel_gradient_prop = font_add_sprite_ext(spr_font_pixel_gradient, "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!?.,\"'$%:<()&-/*", true, 2);
global.map_particles = ds_map_create();

detect_resolution = function()
{
    global.resolution = 0;
    
    if (display_get_width() <= 1920)
        global.resolution = 1;
    
    if (display_get_width() <= 1440)
        global.resolution = 2;
    
    if (display_get_width() <= 1280)
        global.resolution = 3;
    
    if (display_get_width() <= 960)
        global.resolution = 4;
    
    if (global.resolution >= 2)
        global.texfilter = true;
};

resize_resolution = function()
{
    resW[0] = 1920;
    resH[0] = 1080;
    resW[1] = 1440;
    resH[1] = 810;
    resW[2] = 1280;
    resH[2] = 720;
    resW[3] = 960;
    resH[3] = 540;
    resW[4] = 800;
    resH[4] = 450;
    window_set_size(resW[global.resolution], resH[global.resolution]);
    window_center();
};

detect_resolution();
resize_resolution();
ini_open("options.ini");
global.first = ini_read_real("GAME", "First", true);
ini_write_real("GAME", "First", false);
global.resolution = ini_read_real("OPTIONS", "Resolution", 0);
var _fullscreen = ini_read_real("OPTIONS", "Fullscreen", true);

if (_fullscreen)
    window_set_fullscreen(_fullscreen);

global.colorblind = ini_read_real("OPTIONS", "Colorblind", false);
global.texfilter = false;
global.vsync = ini_read_real("OPTIONS", "Vsync", false);
display_reset(0, global.vsync);
global.deadzone = ini_read_real("OPTIONS", "Gamepad Deadzone", 1);
global.crouch_down = true;
global.master_vol = ini_read_real("AUDIO", "Master", 0.5);
global.bgm_vol = ini_read_real("AUDIO", "BGM", 1);
global.sfx_vol = ini_read_real("AUDIO", "SFX", 1);
global.voice_clips = ini_read_real("AUDIO", "Voice Clips", true);
key_defaults[0] = 
{
    up: 38,
    down: 40,
    left: 37,
    right: 39,
    jump: 90,
    spin: 88,
    dash: 67,
    special: 32,
    start: 27
};
key_defaults[1] = 
{
    up: 104,
    down: 101,
    left: 100,
    right: 102,
    jump: 74,
    spin: 75,
    dash: 76,
    special: 8,
    start: 27
};

for (var i = 0; i < array_length(key_defaults); i++)
    key_defaults[i].crouch = key_defaults[i][$ "down"];

for (var i = 0; i < 2; i++)
{
    var _section = $"{i} KEYBOARD";
    global.key_up[i] = ini_read_real(_section, "up", key_defaults[i][$ "up"]);
    global.key_down[i] = ini_read_real(_section, "down", key_defaults[i][$ "down"]);
    global.key_left[i] = ini_read_real(_section, "left", key_defaults[i][$ "left"]);
    global.key_right[i] = ini_read_real(_section, "right", key_defaults[i][$ "right"]);
    global.key_jump[i] = ini_read_real(_section, "jump", key_defaults[i][$ "jump"]);
    global.key_spin[i] = ini_read_real(_section, "spin", key_defaults[i][$ "spin"]);
    global.key_dash[i] = ini_read_real(_section, "dash", key_defaults[i][$ "dash"]);
    global.key_special[i] = ini_read_real(_section, "special", key_defaults[i][$ "special"]);
    global.key_crouch[i] = ini_read_real(_section, "crouch", key_defaults[i][$ "crouch"]);
    global.key_start[i] = ini_read_real(_section, "start", key_defaults[i][$ "start"]);
}

event_user(1);
ini_close();
init_game_globals();
randomize();
global.list_ignorefreeze = ds_list_create();
global.audio_queues = ds_list_create();
global.map_path_yoffs = ds_map_create();
ds_map_add(global.map_path_yoffs, "obj_dynalife", 37);
ds_map_add(global.map_path_yoffs, "obj_bom", 32);
global.particles = 
{
    rundustR: part_type_create(),
    rundustL: part_type_create(),
    jumpdust: part_type_create(),
    dustland: part_type_create(),
    dashsmokeR: part_type_create(),
    dashsmokeL: part_type_create(),
    sparkleGreen: part_type_create(),
    sparkleTinyYellow: part_type_create(),
    explosion: part_type_create(),
    explosion_cyan: part_type_create(),
    explosion_purple: part_type_create(),
    explosion_lime: part_type_create(),
    explosion_yellow: part_type_create(),
    hitmarker: part_type_create(),
    smack: part_type_create(),
    smoke: part_type_create(),
    ring: part_type_create(),
    ringthick: part_type_create(),
    ember: part_type_create()
};
part_type_sprite_simple(global.particles.rundustR, spr_fx_rundust);
part_type_sprite_simple(global.particles.rundustL, spr_fx_rundust);
part_type_scale(global.particles.rundustL, -1, 1);
part_type_sprite_simple(global.particles.jumpdust, spr_fx_jumpdust);
part_type_alpha3(global.particles.jumpdust, 1, 0.75, 0.05);
part_type_sprite_simple(global.particles.dustland, spr_fx_dustland);
part_type_sprite_simple(global.particles.dashsmokeR, spr_fx_dashsmoke);
part_type_sprite_simple(global.particles.dashsmokeL, spr_fx_dashsmoke);
part_type_scale(global.particles.dashsmokeL, -1, 1);
part_type_alpha3(global.particles.dashsmokeR, 1, 0.7, 0.1);
part_type_alpha3(global.particles.dashsmokeL, 1, 0.7, 0.1);
part_type_sprite_simple(global.particles.sparkleGreen, spr_fx_sparkle_green);
part_type_orientation(global.particles.sparkleGreen, 0, 360, choose(-3, 3), 0, 0);
part_type_alpha1(global.particles.sparkleGreen, random_range(0.9, 0.9));
part_type_sprite_simple(global.particles.sparkleTinyYellow, spr_fx_sparkle_tiny_yellow);
part_type_orientation(global.particles.sparkleTinyYellow, 0, 360, choose(-3, 3), 0, 0);
part_type_alpha1(global.particles.sparkleTinyYellow, random_range(0.9, 0.9));
part_type_sprite_simple(global.particles.explosion, spr_fx_explosion);
part_type_sprite_simple(global.particles.explosion_cyan, spr_fx_explosion_cyan);
part_type_sprite_simple(global.particles.explosion_purple, spr_fx_explosion_purple);
part_type_sprite_simple(global.particles.explosion_lime, spr_fx_explosion_lime);
part_type_sprite_simple(global.particles.explosion_yellow, spr_fx_explosion_yellow);
part_type_sprite_simple(global.particles.hitmarker, spr_fx_hitmarker);
part_type_sprite_simple(global.particles.smack, spr_fx_smack);
part_type_sprite_simple(global.particles.smoke, spr_fx_smoke);
part_type_sprite_simple(global.particles.ember, spr_fireball_ember);
var _part = global.particles.ring;
part_type_shape(_part, 5);
part_type_size(_part, 0.1, 0.1, 0.1, 0);
part_type_scale(_part, 1, 1);
part_type_speed(_part, 0, 0, 0, 0);
part_type_direction(_part, 80, 100, 0, 0);
part_type_gravity(_part, 0, 270);
part_type_orientation(_part, 0, 0, 0, 0, false);
part_type_colour2(_part, 65535, 16777215);
part_type_alpha3(_part, 1, 0.7, 0);
part_type_blend(_part, false);
part_type_life(_part, 22, 22);
_part = global.particles.ringthick;
part_type_shape(_part, 5);
part_type_size(_part, 0.2, 0.2, 0.12, 0);
part_type_scale(_part, 1, 1);
part_type_speed(_part, 0, 0, 0, 0);
part_type_direction(_part, 80, 100, 0, 0);
part_type_gravity(_part, 0, 270);
part_type_orientation(_part, 0, 0, 0, 0, false);
part_type_colour2(_part, 16777215, 16777215);
part_type_alpha3(_part, 1, 0.7, 0);
part_type_blend(_part, false);
part_type_life(_part, 22, 22);
global.part_over_nostun = part_system_create_layer("Particles_Over", true);
global.part_over = part_system_create_layer("Particles_Over", true);
global.part_behind = part_system_create_layer("Particles_Behind", true);
global.part_gui = part_system_create_layer("GUI", true);
part_system_automatic_draw(global.part_gui, false);
global.gtexel_size = shader_get_uniform(sha_palswap, "texel_size");
global.gpal_uvs = shader_get_uniform(sha_palswap, "palette_UVs");
global.gpal_index = shader_get_uniform(sha_palswap, "palette_index");
global.gpal_tex = shader_get_sampler_index(sha_palswap, "palette_texture");
shake_default = 0.32;

for (var c = 0; c < 2; c++)
{
    global.screenshake[c] = 0;
    shake_strength[c] = 0;
    shake_speed[c] = shake_default;
}

app_resize = 1;
application_surface_draw_enable(false);
surface_resize(application_surface, 1408, 1080);
view_surf = noone;
sounds = [];
musics = [];
var _counter = 0;

while (audio_exists(_counter))
{
    var _name = audio_get_name(_counter);
    _gain = audio_sound_get_gain(asset_get_index(_name));
    print($"{_name}: {_gain}");
    _counter++;
    
    if (string_char_at(_name, 1) == "s" && string_char_at(_name, 2) == "n" && string_char_at(_name, 3) == "d")
    {
        array_push(sounds, [_name, _gain]);
        continue;
    }
    else if (string_char_at(_name, 1) == "b" && string_char_at(_name, 2) == "g" && string_char_at(_name, 3) == "m")
    {
        array_push(musics, [_name, _gain]);
    }
    else if (string_char_at(_name, 1) == "v" && string_char_at(_name, 2) == "o" && string_char_at(_name, 3) == "i" && string_char_at(_name, 4) == "c" && string_char_at(_name, 5) == "e")
    {
        array_push(sounds, [_name, _gain]);
    }
}

event_user(0);
event_user(3);

if (file_exists(game_save_id + "save.json"))
    global.save = load_json(game_save_id + "save.json");

event_save = function()
{
    if (instance_exists(obj_controller))
    {
        var _side;
        
        if (global.bside)
            _side = "B";
        else
            _side = "A";
        
        variable_struct_set(global.save, $"last_room_{_side}", room_get_name(room));
        variable_struct_set(global.save, $"dollars_{_side}", global.dollars_start);
    }
    
    var _str = json_stringify(global.save, true);
    var _open = file_text_open_write(game_save_id + "save.json");
    file_text_write_string(_open, _str);
    file_text_close(_open);
};

input_profile_create("player2", 1);
global.explosions = [spr_fx_explosion, spr_fx_explosion_cyan, spr_fx_explosion_purple, spr_fx_explosion_lime, spr_fx_explosion_yellow];
global.explosions_parts = [global.particles.explosion, global.particles.explosion_cyan, global.particles.explosion_purple, global.particles.explosion_lime, global.particles.explosion_yellow];
global.input_menu_special = "dash";
global.input_menu_special_glyph = "C";
