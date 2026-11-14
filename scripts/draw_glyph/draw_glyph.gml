function draw_glyph(arg0, arg1, arg2, arg3, arg4)
{
    var _codes = 
    {
        D: global.key_down[0],
        U: global.key_up[0],
        L: global.key_left[0],
        R: global.key_right[0],
        Z: global.key_jump[0],
        X: global.key_spin[0],
        C: global.key_dash[0],
        S: global.key_special[0]
    };
    _codes[$ "0"] = spr_orb;

    var _glyphs_gamepad = 
    {
        L: 0,
        D: 1,
        U: 2,
        R: 3,
        Z: 4,
        X: 5,
        S: 6,
        B: 7,
        C: 8
    };
    var _glyphs_keyboard = {};
    _glyphs_keyboard[$ "37"] = 0;
    _glyphs_keyboard[$ "40"] = 1;
    _glyphs_keyboard[$ "38"] = 2;
    _glyphs_keyboard[$ "39"] = 3;
    _glyphs_keyboard[$ "32"] = 4;
    _glyphs_keyboard[$ "16"] = 5;
    _glyphs_keyboard[$ "160"] = 5;
    _glyphs_keyboard[$ "161"] = 5;
    _glyphs_keyboard[$ "9"] = 6;
    _glyphs_keyboard[$ "17"] = 7;
    _glyphs_keyboard[$ "162"] = 7;
    _glyphs_keyboard[$ "163"] = 7;
    var _keyboard = false;
    
    if (input_source_using(__input_global().__source_keyboard, 0))
        _keyboard = true;
    
    var _glyph_spr = spr_glyph_keyboard;
    
    if (!_keyboard)
    {
        switch (input_player_get_gamepad_type(0))
        {
            case "xbox 360":
            case "xbox one":
                _glyph_spr = spr_glyph_xbox;
                break;
            
            case "psx":
            case "ps4":
            case "ps5":
                _glyph_spr = spr_glyph_ps;
                break;
            
            case "switch":
                _glyph_spr = spr_glyph_switch;
            
            default:
                _glyph_spr = spr_glyph_steam;
        }
    }
    
    var _glyph = arg0;
    var _ind = -1;
    
    if (!_keyboard)
    {
        if (struct_exists(_glyphs_gamepad, _glyph))
            _ind = variable_struct_get(_glyphs_gamepad, _glyph);
    }
    
    var _x = arg1;
    var _y = arg2;
    draw_sprite_ext(_glyph_spr, _ind + 1, arg1, arg2, arg3, arg3, 0, c_white, arg4);
    var _font = draw_get_font();
    draw_set_font(obj_persistent.font_pixel);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    if (_keyboard)
    {
        _ind = -1;
        var _txt = struct_get(_codes, _glyph);
        
        if (struct_exists(_glyphs_keyboard, string(_txt)))
            _ind = variable_struct_get(_glyphs_keyboard, string(_txt));
        else if (struct_exists(global.key_names, _txt))
            _txt = variable_struct_get(global.key_names, _txt);
        
        if (_ind != -1)
        {
            draw_sprite_ext(_glyph_spr, _ind + 1, _x, _y, arg3, arg3, 0, c_white, draw_get_alpha());
        }
        else
        {
            var _col = draw_get_color();
            draw_set_color(#BABABA);
            draw_text_transformed(_x + (37 * arg3), _y + (38 * arg3), _txt, 2.85 * arg3, 2.85 * arg3, 0);
            draw_set_color(_col);
        }
    }
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_font(_font);
}
