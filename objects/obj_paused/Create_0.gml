event_inherited();

event_cleanup = function()
{
    if (sprite_exists(spr))
        sprite_delete(spr);
    
    if (surface_exists(surf))
        surface_free(surf);
};

surf = noone;
audio_pause_all();
audio_resume_sound(global.bgmPlay);
audio_sound_gain(global.bgmPlay, 0.285, 0);
spr = sprite_create_from_surface(obj_controller.view_surf, 0, 0, 1408, surface_get_height(application_surface), 0, 0, 0, 0);
instance_deactivate_all(true);
instance_activate_object(obj_persistent);
instance_activate_object(obj_controller);
instance_activate_object(obj_editor);
instance_activate_object(input_controller_object);

var _resume = function()
{
    event_unpause();
};

var _die = function()
{
    global.bubble = false;
    event_unpause();
    
    with (obj_player)
    {
        hurt_by = obj_paused;
        invulnerable = false;
        event_user(0);
    }
};

swap_snd = noone;

event_multiplayer = function()
{
    if (global.players == 2)
    {
        options_event[0]();
        
        with (obj_player2)
            instance_destroy();
        
        global.players = 1;
        exit;
    }
    
    if (!instance_exists(obj_multiplayer))
        instance_create_depth(0, 0, depth - 100, obj_multiplayer);
};

var _options = function()
{
    var _inst = instance_create_depth(0, 0, depth - 100, obj_options);
    
    with (_inst)
    {
        ready = true;
        frame = array_length(box_xscale) - 1;
        visible = false;
    }
};

var _exit = function()
{
    var _room = room_goto_fade(rm_title, 120);
    var _wizard = array_contains(global.wizard_events_total, room);
    
    if (array_contains(global.stages_outskirts, room))
        _wizard = false;
    
    if (!array_contains(global.stages_tutorial, room) && !_wizard && !array_contains(global.stages_final, room) && !global.round_select)
    {
        with (obj_persistent)
            event_save();
    }
    
    _room.func_roomend = function()
    {
        audio_stop_all();
    };
    
    if (audio_is_playing(global.bgmPlay))
        audio_sound_gain(global.bgmPlay, 0, 1500);
};

var _palettes = function()
{
    var _inst = instance_create_depth(0, 0, depth, obj_achievements);
};

var _exit_text = "EXIT & SAVE";

if (global.round_select || array_contains(global.stages_tutorial, room))
    _exit_text = "EXIT";

options = ["RESUME", "DIE", "PALETTES", "OPTIONS", _exit_text];
options_event = [_resume, _die, _palettes, _options, _exit];

event_unpause = function()
{
    instance_activate_all();
    audio_resume_all();
    audio_sound_gain(global.bgmPlay, 1, 0);
    instance_destroy();
};

var _buster = choose(0, 0, 0, 1);

if (_buster)
    timer[0] = 540;
else
    timer[0] = 1500;

if (global.playground)
    timer[0] = -1;

timer_func[0] = function()
{
    little_buster_go = true;
};

buster_state = 0;
little_buster_go = false;
buster_spr = undefined;
buster_frame = 0;
delay = 0;
var _snd = audio_play_sound(snd_paused, 0, false);
audio_sound_gain(_snd, 0.7, 0);
