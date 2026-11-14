event_inherited();
paused_ind = 2;
hand_ind = 0;

func_na = function()
{
};

var func_game = function()
{
    menu = "game";
    options = menu_game.options;
    options_event = menu_game.functions;
    selected = 0;
};

var func_video = function()
{
    menu = "video";
    options = menu_video.options;
    options_event = menu_video.functions;
    selected = 0;
};

var func_audio = function()
{
    menu = "audio";
    options = menu_audio.options;
    options_event = menu_audio.functions;
    selected = 0;
};

var func_back = function()
{
    input_verb_consume_all("jump");
    instance_destroy();
};

var func_howto = function()
{
    deac = true;
    instance_create_depth(0, 0, depth, obj_howtoplay);
};

var func_back_game = function()
{
    menu = "main";
    options = menu_main.options;
    options_event = menu_main.functions;
    selected = 0;
};

var func_back_video = function()
{
    menu = "main";
    options = menu_main.options;
    options_event = menu_main.functions;
    selected = 1;
};

var func_back_audio = function()
{
    menu = "main";
    options = menu_main.options;
    options_event = menu_main.functions;
    selected = 2;
};

menu_main = 
{
    menu: "main",
    options: ["GAME", "VIDEO", "AUDIO", "HOW TO PLAY", "BACK"],
    functions: [func_game, func_video, func_audio, func_howto, func_back]
};
menu = "main";
options = ["GAME", "VIDEO", "AUDIO", "HOW TO PLAY", "BACK"];
options_event = [func_game, func_video, func_audio, func_howto, func_back];

var func_remap = function()
{
    menu_selected = menu_remap;
    selected_option = 0;
};

var func_deadzone = function()
{
    var _xAxis = input_check_pressed_all("right") - input_check_pressed_all("left");
    
    if (input_check_all("jump"))
        _xAxis = 1;
    
    if (_xAxis != 0)
    {
        global.deadzone += _xAxis;
        
        if (global.deadzone > 2)
            global.deadzone = 0;
        
        ini_open("options.ini");
        ini_write_real("OPTIONS", "Gamepad Deadzone", global.deadzone);
        ini_close();
    }
};

var func_resetpad = function()
{
    global.deadzone = 1;
    ini_open("options.ini");
    ini_write_real("OPTIONS", "Gamepad Deadzone", global.deadzone);
    ini_close();
};

menu_game = 
{
    menu: "game",
    options: ["REMAP KEYBOARD", "PAD DEADZONE", "RESET PAD DEFAULT", "BACK"],
    functions: [func_remap, func_deadzone, func_resetpad, func_back_game]
};
invalid_wait = 180;
invalid_time = -1;
invalid_str = "KEY ALREADY USED BY PLAYER!";
button_wait = 300;
button_time = -1;

var func_player = function()
{
    menu_selected.player = !menu_selected[$ "player"];
};

var func_back_remap = function()
{
    menu = "game";
    options = menu_game.options;
    options_event = menu_game.functions;
    menu_selected = menu_main;
    selected = 0;
};

var func_button = function()
{
    button_time = button_wait;
};

var func_restore = function()
{
    with (obj_persistent)
    {
        for (var i = 0; i < 2; i++)
        {
            var _arr = struct_get_names(key_defaults[i]);
            
            for (var j = 0; j < array_length(_arr); j++)
            {
                var _key = $"key_{_arr[j]}";
                print(_key);
                var _struct = variable_global_get(_key);
                _struct[i] = variable_struct_get(obj_persistent.key_defaults[i], _arr[j]);
                print(variable_struct_get(obj_persistent.key_defaults[i], _arr[j]));
                variable_global_set(_key, _struct);
            }
        }
        
        event_user(1);
    }
};

menu_remap = 
{
    menu: "remap",
    player: 0,
    options: ["PLAYER", "UP", "DOWN", "LEFT", "RIGHT", "JUMP", "SPIN", "DASH", "SPECIAL", "START", "RESTORE TO DEFAULTS", "BACK"],
    functions: [func_player, func_button, func_button, func_button, func_button, func_button, func_button, func_button, func_button, func_button, func_restore, func_back_remap]
};

var setKeyName = function(arg0, arg1)
{
    key_names[arg0] = arg1;
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

func_video = function()
{
    switch (options[selected])
    {
        case "RESOLUTION":
            var _xAxis = input_check_all("right") - input_check_all("left");
            
            if (input_check_all("jump"))
                _xAxis = 1;
            
            if (_xAxis != 0)
            {
                global.resolution -= _xAxis;
                
                if (global.resolution > 4)
                    global.resolution = 0;
                
                if (global.resolution < 0)
                    global.resolution = 4;
                
                with (obj_persistent)
                    resize_resolution();
                
                ini_open("options.ini");
                ini_write_real("OPTIONS", "Resolution", global.resolution);
                ini_write_real("OPTIONS", "Fullscreen", window_get_fullscreen());
                ini_close();
            }
            
            break;
        
        case "FULLSCREEN":
            window_set_fullscreen(!window_get_fullscreen());
            
            with (obj_persistent)
                resize_resolution();
            
            ini_open("options.ini");
            ini_write_real("OPTIONS", "Fullscreen", window_get_fullscreen());
            ini_close();
            break;
        
        case "COLORBLIND":
            global.colorblind = !global.colorblind;
            ini_open("options.ini");
            ini_write_real("OPTIONS", "Colorblind", global.colorblind);
            ini_close();
            break;
        
        case "TEXTURE FILTER":
            global.texfilter = !global.texfilter;
            gpu_set_texfilter(global.texfilter);
            ini_open("options.ini");
            ini_write_real("OPTIONS", "Texture Filter", global.texfilter);
            ini_close();
            break;
        
        case "VSYNC":
            global.vsync = !global.vsync;
            display_reset(0, global.vsync);
            ini_open("options.ini");
            ini_write_real("OPTIONS", "Vsync", global.vsync);
            ini_close();
            break;
    }
};

menu_video = 
{
    menu: "video",
    options: ["RESOLUTION", "FULLSCREEN", "COLORBLIND", "VSYNC", "BACK"],
    functions: [func_video, func_video, func_video, func_video, func_back_video]
};

func_audio = function()
{
    if (input_check_all("jump"))
        exit;
    
    var _xAxis = input_check_pressed_all("right") - input_check_pressed_all("left");
    
    if (_xAxis != 0)
    {
        if (selected != 1)
            audio_play_sound(snd_nab, 0, 0);
        
        if (selected == 0)
            global.master_vol += (0.1 * _xAxis);
        else if (selected == 1)
            global.bgm_vol += (0.1 * _xAxis);
        else if (selected == 2)
            global.sfx_vol += (0.1 * _xAxis);
        
        global.master_vol = clamp(global.master_vol, 0, 1);
        global.bgm_vol = clamp(global.bgm_vol, 0, 1);
        global.sfx_vol = clamp(global.sfx_vol, 0, 1);
        global.master_vol = round(global.master_vol * 10) / 10;
        global.bgm_vol = round(global.bgm_vol * 10) / 10;
        global.sfx_vol = round(global.sfx_vol * 10) / 10;
        
        with (obj_persistent)
            event_user(0);
        
        ini_open("options.ini");
        ini_write_real("AUDIO", "Master", global.master_vol);
        ini_write_real("AUDIO", "BGM", global.bgm_vol);
        ini_write_real("AUDIO", "SFX", global.sfx_vol);
        ini_write_real("AUDIO", "Voice Clips", global.voice_clips);
        ini_close();
    }
};

var func_voice_clips = function()
{
    global.voice_clips = !global.voice_clips;
};

menu_audio = 
{
    menu: "audio",
    options: ["MASTER", "BGM", "SFX", "VOICE", "BACK"],
    functions: [func_audio, func_audio, func_audio, func_voice_clips, func_back_audio]
};
menu_selected = menu_main;
selected_option = 0;
