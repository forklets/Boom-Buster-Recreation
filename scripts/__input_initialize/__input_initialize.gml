// Input 8.1.3 (2025-04-14) by Juju Adams and Alynne Keith - MIT licence

__input_initialize();

function __input_initialize()
{
    static _initialized = false;

    if (_initialized)
        exit;

    _initialized = true;

    var _global = __input_global();

    _global.__debug_log = "input___" + string_replace_all(string_replace_all(date_datetime_string(date_current_datetime()), ":", "-"), " ", "___") + ".txt";
    __input_trace("Welcome to Input by Juju Adams and Alynne Keith! This is version ", "8.1.3", ", ", "2025-04-14");

    #region Feature detection

    if (is_undefined(infinity))
        __input_error("Error!\nGM constant 'infinity' is undefined. Please file a bug with YoYoGames.");

    var _use_split_and_trim;

    try
    {
        var _split = array_equals(string_split("Juju\nwaz\nere", "\n", true), ["Juju", "waz", "ere"]);
        var _trim = string_trim("         you can't catch me          ") == "you can't catch me";
        _use_split_and_trim = _split && _trim;
    }
    catch (_error)
    {
        _use_split_and_trim = false;
    }

    if (!_use_split_and_trim)
        __input_error("Error!\nGM extended string functions are unavailable. Please update GameMaker.");

    var _native_split;

    try
    {
        if (is_real(string_split))
            _native_split = real(string_split) < 100000;
        else
            _native_split = is_struct(string_split);
    }
    catch (_error)
    {
        _native_split = false;
    }

    if (!_native_split)
        __input_trace_loud("Warning!\nFound indirection for GM native \"string_split\" function. Overriding \"string_split\" degrades load performance.");

    try
    {
        var _instance_of = is_instanceof(input_binding_empty(), __input_class_binding);
        _global.__use_is_instanceof = _instance_of;
    }
    catch (_error)
    {
        _global.__use_is_instanceof = false;
    }

    __input_trace(_global.__use_is_instanceof ? "Using is_instanceof() for comparisons" : "is_instanceof() unavailable, using legacy comparisons");

    _global.__use_gp_extended = false;

    try
    {
        _global.__use_gp_extended = is_numeric(gp_home) && is_numeric(gp_extra1) && is_numeric(gp_paddler) && is_numeric(gp_paddlel) && is_numeric(gp_paddlerb) && is_numeric(gp_paddlelb) && is_numeric(gp_touchpadbutton);
    }
    catch (_error)
    {
        _global.__use_gp_extended = false;
    }

    if (_global.__use_gp_extended)
    {
        _global.__gp_guide = gp_home;
        _global.__gp_misc1 = gp_extra1;
        _global.__gp_touchpad = gp_touchpadbutton;
        _global.__gp_paddle1 = gp_paddler;
        _global.__gp_paddle2 = gp_paddlel;
        _global.__gp_paddle3 = gp_paddlerb;
        _global.__gp_paddle4 = gp_paddlelb;
        __input_trace("Using native extended gamepad values");
    }
    else
    {
        _global.__gp_guide = 32889;
        _global.__gp_misc1 = 32890;
        _global.__gp_touchpad = 32891;
        _global.__gp_paddle1 = 32892;
        _global.__gp_paddle2 = 32893;
        _global.__gp_paddle3 = 32894;
        _global.__gp_paddle4 = 32895;
        __input_trace("Native extended gamepad values unavailable");
    }

    try
    {
        var _overlay_open = is_debug_overlay_open();
        _global.__use_debug_overlay_status = is_bool(_overlay_open);
    }
    catch (_error)
    {
        _global.__use_debug_overlay_status = false;
    }

    __input_trace(_global.__use_debug_overlay_status ? "Using debug overlay status to block input" : "Debug overlay status is unavailable");

    try
    {
        ref_create({ x: 32 }, "x");
        _global.__allow_gamepad_tester = true;
    }
    catch (_error)
    {
        _global.__allow_gamepad_tester = false;
    }

    __input_trace(_global.__allow_gamepad_tester ? "Allowing native gamepad tester" : "Native gamepad tester is unavailable");

    if (_global.__allow_gamepad_tester)
        __input_gamepad_tester_init();

    _global.__allow_gamepad_enumerate = false;

    #endregion

    #region On-boot warnings and errors

    _global.__time_source = time_source_create(time_source_global, 1, time_source_units_frames, function()
    {
        static _created = false;

        if (!instance_exists(input_controller_object))
        {
            instance_activate_object(input_controller_object);

            if (instance_exists(input_controller_object))
            {
                __input_trace("Warning! input_controller_object has been deactivated. Please ensure that input_controller_object is never deactivated. You may need to use instance_activate_object(input_controller_object)");
            }
            else
            {
                if (!_created)
                    _created = true;
                else if (__input_restart_get())
                    __input_trace("Warning! Please consider an alternative method to reset game state: avoid using \"game_restart()\"");
                else
                    __input_trace("Warning! input_controller_object has been destroyed. Please ensure that input_controller_object is never destroyed");

                instance_create_depth(0, -16001, 16001, input_controller_object);
            }
        }

        if (!input_controller_object.persistent)
        {
            __input_trace("Warning! input_controller_object has been set as non-persistent. Please ensure that input_controller_object is always persistent");
            input_controller_object.persistent = true;
        }

        if (input_controller_object.depth != 16001)
        {
            __input_trace("Warning! input_controller_object depth has been changed (expected ", 16001, ", got ", input_controller_object.depth, ")\nPlease ensure that input_controller_object is never manually created and depth is not manually set");
            input_controller_object.depth = 16001;
        }
    }, [], -1);

    time_source_start(_global.__time_source);

    if (string_pos("127.0.0.1", parameter_string(0)) > 0 || string_pos("localhost", parameter_string(0)) > 0)
        show_message("Due to changes in security policy, some browsers may not permit the use of gamepads when testing locally.\n \nPlease host on a remote web service (itch.io, GX.games, etc.) if you are encountering problems.");

    #endregion

    _global.__frame = 0;
    _global.__current_time = current_time;
    _global.__previous_current_time = current_time;
    _global.__restart_time = -infinity;
    _global.__enumeration_time = -infinity;
    _global.__cleared = false;

    _global.__window_focus = true;
    _global.__overlay_focus = false;
    _global.__game_input_allowed = true;
    _global.__use_native_focus = true;

    _global.__toggle_momentary_dict = {};
    _global.__toggle_momentary_state = false;
    _global.__cooldown_dict = {};
    _global.__cooldown_state = false;

    _global.__tap_presses = 0;
    _global.__tap_releases = 0;
    _global.__tap_click = false;

    _global.__pointer_index = 0;
    _global.__pointer_index_previous = 0;
    _global.__pointer_pressed = false;
    _global.__pointer_released = false;
    _global.__pointer_pressed_index = undefined;
    _global.__pointer_coord_space = 0;
    _global.__pointer_held_time = array_create(11, -1);
    _global.__pointer_held_buffer = array_create(11, false);
    _global.__pointer_x = array_create(3, 0);
    _global.__pointer_y = array_create(3, 0);
    _global.__pointer_dx = array_create(3, 0);
    _global.__pointer_dy = array_create(3, 0);
    _global.__pointer_moved = false;

    _global.__mouse_capture = false;
    _global.__mouse_capture_blocked = false;
    _global.__mouse_capture_sensitivity = 1;
    _global.__mouse_capture_frame = 0;

    _global.__on_desktop = true;
    _global.__on_mobile = false;

    _global.__strict_binding_check = false;
    _global.__any_keyboard_binding_defined = false;
    _global.__any_mouse_binding_defined = false;
    _global.__any_touch_binding_defined = false;
    _global.__any_gamepad_binding_defined = false;

    _global.__gamepad_allowed = __input_global().__on_desktop || __input_global().__on_mobile;
    _global.__keyboard_allowed = __input_global().__on_desktop == true;
    _global.__mouse_allowed = __input_global().__on_desktop == true;
    _global.__touch_allowed = __input_global().__on_mobile == true;

    _global.__vibration_allowed = false;

    if (_global.__gamepad_allowed)
        _global.__vibration_allowed = true;

    if (_global.__mouse_allowed && _global.__touch_allowed)
        _global.__touch_allowed = false;

    _global.__window_focus_block_mouse = false;
    _global.__window_focus_frame = -infinity;
    _global.__cursor_verbs_valid = false;

    _global.__all_verb_dict = {};
    _global.__all_verb_array = [];
    _global.__basic_verb_dict = {};
    _global.__basic_verb_array = [];
    _global.__chord_verb_dict = {};
    _global.__chord_verb_array = [];
    _global.__key_name_dict = {};
    _global.__ignore_key_dict = {};
    _global.__ignore_gamepad_types = {};

    _global.__virtual_array = [];
    _global.__virtual_background = input_virtual_create().__set_as_background();
    _global.__virtual_order_dirty = false;
    _global.__touch_player = undefined;

    var _max_gamepads = 12;

    _global.__players_status =
    {
        __any_changed: false,
        __new_connections: [],
        __new_disconnections: [],
        __players: array_create(2, 0)
    };

    _global.__gamepads_status =
    {
        __any_changed: false,
        __new_connections: [],
        __new_disconnections: [],
        __gamepads: array_create(_max_gamepads, 0)
    };

    _global.__default_player = new __input_class_player();
    _global.__players = array_create(2, undefined);

    var _p = 0;

    repeat (2)
    {
        with (new __input_class_player())
        {
            _global.__players[_p] = self;
            __index = _p;
        }

        _p++;
    }

    _global.__source_mode = undefined;
    _global.__previous_source_mode = 2;
    _global.__hotswap_callback = undefined;

    _global.__join_player_min = 1;
    _global.__join_player_max = 2;
    _global.__join_leave_verb = "cancel";
    _global.__join_abort_callback = undefined;
    _global.__join_drop_down = true;

    _global.__gamepads = array_create(_max_gamepads, undefined);
    _global.__gamepad_connections_native = array_create(_max_gamepads, false);
    _global.__gamepad_connections_internal = array_create(_max_gamepads, false);

    _global.__sdl2_database =
    {
        by_guid: {},
        by_vendor_product: {},
        by_description: {}
    };

    _global.__sdl2_look_up_table =
    {
        a: gp_face1,
        b: gp_face2,
        x: gp_face3,
        y: gp_face4,
        dpup: gp_padu,
        dpdown: gp_padd,
        dpleft: gp_padl,
        dpright: gp_padr,
        leftx: gp_axislh,
        lefty: gp_axislv,
        rightx: gp_axisrh,
        righty: gp_axisrv,
        leftshoulder: gp_shoulderl,
        rightshoulder: gp_shoulderr,
        lefttrigger: gp_shoulderlb,
        righttrigger: gp_shoulderrb,
        leftstick: gp_stickl,
        rightstick: gp_stickr,
        start: gp_start,
        back: gp_select,
        guide: __input_global().__gp_guide,
        misc1: __input_global().__gp_misc1,
        touchpad: __input_global().__gp_touchpad,
        paddle1: __input_global().__gp_paddle1,
        paddle2: __input_global().__gp_paddle2,
        paddle3: __input_global().__gp_paddle3,
        paddle4: __input_global().__gp_paddle4
    };

    #region Gamepad mapping database

    if (!__input_global().__on_desktop)
    {
        __input_trace("Skipping loading SDL database");
    }
    else
    {
        if (file_exists("sdl2.txt"))
            __input_load_sdl2_from_file("sdl2.txt");
        else
            __input_trace("Warning! \"", "sdl2.txt", "\" not found in Included Files");

        var _external_string = environment_get_variable("SDL_GAMECONTROLLERCONFIG");

        if (_external_string != "")
        {
            __input_trace("External SDL2 string found");

            try
            {
                __input_load_sdl2_from_string(_external_string);
            }
            catch (_error)
            {
                __input_trace_loud("Error!\n\n%SDL_GAMECONTROLLERCONFIG% could not be parsed.\nYou may see unexpected behaviour when using gamepads.\n\nTo remove this error, clear %SDL_GAMECONTROLLERCONFIG%\n\nInput ", "8.1.3", "   @jujuadams and @offalynne ", "2025-04-14");
            }
        }
    }

    #endregion

    #region Gamepad type identification

    __input_define_gamepad_types();
    _global.__raw_type_dictionary = {};

    if (file_exists("controllertypes.csv"))
        __input_load_type_csv("controllertypes.csv");
    else
        __input_trace("Warning! \"", "controllertypes.csv", "\" not found in Included Files");

    #endregion

    #region Gamepad device blocklist

    _global.__blacklist_dictionary = {};

    if (!__input_global().__on_desktop)
    {
        __input_trace("Skipping loading controller blacklist database");
    }
    else if (file_exists("controllerblacklist.csv"))
    {
        __input_load_blacklist_csv("controllerblacklist.csv");
    }
    else
    {
        __input_trace("Warning! \"", "controllerblacklist.csv", "\" not found in Included Files");
    }

    #endregion

    #region Gamepad LED patterns by device type

    var _dict = {};

    _dict[$ "ps5"] =
    [
        [false, false, true, false, false],
        [false, true, false, true, false],
        [true, false, true, false, true],
        [true, true, false, true, true]
    ];

    _dict[$ "switch"] =
    [
        [true, false, false, false],
        [true, true, false, false],
        [true, true, true, false],
        [true, true, true, true],
        [true, false, false, true],
        [true, false, true, false],
        [true, false, true, true],
        [false, true, true, false]
    ];

    _dict[$ "xbox 360"] =
    [
        [true, false, false, false],
        [false, true, false, false],
        [false, false, true, false],
        [false, false, false, true]
    ];

    _global.__gamepad_led_pattern_dict = _dict;

    #endregion

    #region Device locale

    _global.__ps_region_swap = false;
    _global.__keyboard_locale = "QWERTY";
    var _locale = os_get_language() + "-" + os_get_region();

    switch (_locale)
    {
        case "ar-DZ": case "ar-MA": case "ar-TN":
        case "br-FR": case "co-FR": case "ff-SN":
        case "fr-BE": case "fr-CD": case "fr-CI":
        case "fr-CM": case "fr-FR": case "fr-HT":
        case "fr-MA": case "fr-MC": case "fr-ML":
        case "fr-RE": case "nl-BE": case "oc-FR":
        case "wo-SN": case "tzm-DZ":
        case "mg-": case "gsw-FR":
            _global.__keyboard_locale = "AZERTY";
            break;

        case "cs-CZ": case "de-AT": case "de-CH":
        case "de-DE": case "de-LI": case "de-LU":
        case "fr-CH": case "fr-LU": case "sq-AL":
        case "hr-BA": case "hr-HR": case "hu-HU":
        case "lb-LU": case "rm-CH": case "sk-SK":
        case "sl-SI": case "dsb-DE":
        case "sr-BA": case "hsb-DE":
            _global.__keyboard_locale = "QWERTZ";
            break;
    }

    #endregion

    #region Key names

    __input_key_name_set(192, "`");
    __input_key_name_set(189, "-");
    __input_key_name_set(187, "=");
    __input_key_name_set(186, ";");
    __input_key_name_set(222, "'");
    __input_key_name_set(188, ",");
    __input_key_name_set(190, ".");
    __input_key_name_set(221, "]");
    __input_key_name_set(219, "[");
    __input_key_name_set(191, "/");
    __input_key_name_set(220, "\\");

    __input_key_name_set(145, "scroll lock");
    __input_key_name_set(20, "caps lock");
    __input_key_name_set(144, "num lock");
    __input_key_name_set(91, "left meta");
    __input_key_name_set(92, "right meta");
    __input_key_name_set(12, "clear");
    __input_key_name_set(93, "menu");

    __input_key_name_set(vk_printscreen, "print screen");
    __input_key_name_set(vk_pause, "pause break");

    __input_key_name_set(vk_escape, "escape");
    __input_key_name_set(vk_backspace, "backspace");
    __input_key_name_set(vk_space, "space");
    __input_key_name_set(vk_enter, "enter");

    __input_key_name_set(vk_up, "arrow up");
    __input_key_name_set(vk_down, "arrow down");
    __input_key_name_set(vk_left, "arrow left");
    __input_key_name_set(vk_right, "arrow right");

    __input_key_name_set(vk_tab, "tab");
    __input_key_name_set(vk_ralt, "right alt");
    __input_key_name_set(vk_lalt, "left alt");
    __input_key_name_set(vk_alt, "alt");
    __input_key_name_set(vk_rshift, "right shift");
    __input_key_name_set(vk_lshift, "left shift");
    __input_key_name_set(vk_shift, "shift");
    __input_key_name_set(vk_rcontrol, "right ctrl");
    __input_key_name_set(vk_lcontrol, "left ctrl");
    __input_key_name_set(vk_control, "ctrl");

    __input_key_name_set(vk_f1, "f1");
    __input_key_name_set(vk_f2, "f2");
    __input_key_name_set(vk_f3, "f3");
    __input_key_name_set(vk_f4, "f4");
    __input_key_name_set(vk_f5, "f5");
    __input_key_name_set(vk_f6, "f6");
    __input_key_name_set(vk_f7, "f7");
    __input_key_name_set(vk_f8, "f8");
    __input_key_name_set(vk_f9, "f9");
    __input_key_name_set(vk_f10, "f10");
    __input_key_name_set(vk_f11, "f11");
    __input_key_name_set(vk_f12, "f12");

    __input_key_name_set(vk_divide, "numpad /");
    __input_key_name_set(vk_multiply, "numpad *");
    __input_key_name_set(vk_subtract, "numpad -");
    __input_key_name_set(vk_add, "numpad +");
    __input_key_name_set(vk_decimal, "numpad .");

    __input_key_name_set(vk_numpad0, "numpad 0");
    __input_key_name_set(vk_numpad1, "numpad 1");
    __input_key_name_set(vk_numpad2, "numpad 2");
    __input_key_name_set(vk_numpad3, "numpad 3");
    __input_key_name_set(vk_numpad4, "numpad 4");
    __input_key_name_set(vk_numpad5, "numpad 5");
    __input_key_name_set(vk_numpad6, "numpad 6");
    __input_key_name_set(vk_numpad7, "numpad 7");
    __input_key_name_set(vk_numpad8, "numpad 8");
    __input_key_name_set(vk_numpad9, "numpad 9");

    __input_key_name_set(vk_delete, "delete");
    __input_key_name_set(vk_insert, "insert");
    __input_key_name_set(vk_home, "home");
    __input_key_name_set(vk_pageup, "page up");
    __input_key_name_set(vk_pagedown, "page down");
    __input_key_name_set(vk_end, "end");

    __input_key_name_set(10, variable_struct_get(_global.__key_name_dict, vk_enter));

    for (var _i = 13; _i <= 32; _i++)
        __input_key_name_set((_i + vk_f1) - 1, "f" + string(_i));

    __input_key_name_set(226, "<");

    switch (__input_global().__keyboard_locale)
    {
        case "QWERTY":
            __input_key_name_set(223, "`");
            break;

        case "AZERTY":
            __input_key_name_set(223, "!");
            break;

        case "QWERTZ":
            __input_key_name_set(223, "$");
            break;
    }

    #endregion

    #region Ignored keys

    input_ignore_key_add(vk_alt);
    input_ignore_key_add(vk_ralt);
    input_ignore_key_add(vk_lalt);
    input_ignore_key_add(91);
    input_ignore_key_add(92);
    input_ignore_key_add(255);
    input_ignore_key_add(230);

    input_ignore_key_add(144);
    input_ignore_key_add(145);

    input_ignore_key_add(21);
    input_ignore_key_add(22);
    input_ignore_key_add(23);
    input_ignore_key_add(24);
    input_ignore_key_add(25);
    input_ignore_key_add(26);
    input_ignore_key_add(28);
    input_ignore_key_add(29);
    input_ignore_key_add(30);
    input_ignore_key_add(31);
    input_ignore_key_add(229);

    input_ignore_key_add(166);
    input_ignore_key_add(167);
    input_ignore_key_add(168);
    input_ignore_key_add(169);
    input_ignore_key_add(170);
    input_ignore_key_add(171);
    input_ignore_key_add(172);

    input_ignore_key_add(173);
    input_ignore_key_add(174);
    input_ignore_key_add(175);
    input_ignore_key_add(176);
    input_ignore_key_add(177);
    input_ignore_key_add(178);
    input_ignore_key_add(179);

    input_ignore_key_add(180);
    input_ignore_key_add(181);
    input_ignore_key_add(182);
    input_ignore_key_add(183);

    input_ignore_key_add(251);

    #endregion

    #region Steam Input

    _global.__steam_switch_labels = false;
    _global.__using_steamworks = false;
    _global.__on_steam_deck = false;
    _global.__on_wine = false;
    _global.__steam_handles = [];
    _global.__steam_type_to_raw = {};
    _global.__steam_type_to_name = {};
    _global.__steam_trigger_mode = {};

    if (extension_exists("Steamworks"))
    {
        try
        {
            _global.__using_steamworks = steam_input_init(true);
            _global.__on_steam_deck = steam_utils_is_steam_running_on_steam_deck();
        }
        catch (_error)
        {
            __input_trace("Steamworks extension unavailable");
        }

        if (_global.__using_steamworks && string(steam_get_app_id()) == "480")
            __input_trace_loud("Error!\nSteamworks extension incorrectly configured (Application ID 480).\nYou may see unexpected behaviour when using gamepads.\n\nTo remove this error, set Application ID.\n\nInput ", "8.1.3", "   @jujuadams and @offalynne ", "2025-04-14");
    }

    if (!_global.__on_steam_deck)
    {
        var _deck_envar = environment_get_variable("SteamDeck");

        if (_deck_envar != "")
        {
            _global.__on_steam_deck = _deck_envar == "1";
        }
        else
        {
            var _map = os_get_info();

            if (ds_exists(_map, ds_type_map))
            {
                var _identifier = undefined;
                _identifier = _map[? "video_adapter_description"];

                if (_identifier != undefined && __input_string_contains(_identifier, "AMD Custom GPU 0"))
                    _global.__on_steam_deck = true;

                ds_map_destroy(_map);
            }
        }
    }

    var _switch_labels = environment_get_variable("SDL_GAMECONTROLLER_USE_BUTTON_LABELS");

    if (_switch_labels != "")
        _global.__steam_switch_labels = _switch_labels == "1";
    else
        _global.__steam_switch_labels = _global.__on_steam_deck;

    if (_global.__using_steamworks)
    {
        _global.__on_wine = environment_get_variable("WINEDLLPATH") != "";

        __input_steam_type_set(2, "XBox360Controller", "Xbox 360 Controller");
        __input_steam_type_set(3, "XBoxOneController", "Xbox One Controller");
        __input_steam_type_set(12, "PS3Controller", "PS3 Controller");
        __input_steam_type_set(5, "PS4Controller", "PS4 Controller");
        __input_steam_type_set(13, "PS5Controller", "PS5 Controller");
        __input_steam_type_set(1, "SteamController", "Steam Controller");
        __input_steam_type_set(14, "SteamControllerNeptune", "Steam Deck Controller");
        __input_steam_type_set(11, "MobileTouch", "Steam Link");

        if (_global.__steam_switch_labels)
        {
            __input_steam_type_set(10, "XBox360Controller", "Switch Pro Controller");
            __input_steam_type_set(9, "XBox360Controller", "Joy-Con");
            __input_steam_type_set(8, "XBox360Controller", "Joy-Con Pair");
        }
        else
        {
            __input_steam_type_set(10, "SwitchProController", "Switch Pro Controller");
            __input_steam_type_set(9, "SwitchJoyConSingle", "Joy-Con");
            __input_steam_type_set(8, "SwitchJoyConPair", "Joy-Con Pair");
        }

        __input_steam_type_set("unknown", "UnknownNonSteamController", "Controller");

        variable_struct_set(_global.__steam_trigger_mode, "0", 0);
        variable_struct_set(_global.__steam_trigger_mode, "1", 1);
        variable_struct_set(_global.__steam_trigger_mode, "2", 2);
        variable_struct_set(_global.__steam_trigger_mode, "3", 3);
    }

    #endregion

    if (__input_global().__on_mobile)
        _global.__keyboard_type = "virtual";
    else
        _global.__keyboard_type = "keyboard";

    if (__input_global().__on_steam_deck || __input_global().__on_mobile || _global.__touch_allowed)
        _global.__pointer_type = "touch";
    else
        _global.__pointer_type = "mouse";

    _global.__gamepad_motion_support = _global.__using_steamworks == true;

    device_mouse_dbclick_enable(false);

    _global.__profile_array = undefined;
    _global.__profile_dict = undefined;
    _global.__default_profile_dict = undefined;
    _global.__verb_to_group_dict = {};
    _global.__group_to_verbs_dict = {};
    _global.__verb_group_array = [];
    _global.__icons = {};

    _global.__source_keyboard = new __input_class_source(0);
    _global.__source_mouse = __input_global().__source_keyboard;
    _global.__source_touch = new __input_class_source(3);
    _global.__source_gamepad = array_create(_max_gamepads, undefined);

    var _g = 0;

    repeat (_max_gamepads)
    {
        _global.__source_gamepad[_g] = new __input_class_source(2, _g);
        _g++;
    }

    __input_finalize_default_profiles();
    __input_finalize_verb_groups();
    input_source_mode_set(2);
    __input_validate_macros();
    return true;
}
