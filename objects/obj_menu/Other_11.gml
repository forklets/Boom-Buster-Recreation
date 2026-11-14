if (global.playground)
{
    draw_sprite_tiled(spr_static, current_time / 50, 0, 0);
    draw_sprite_tiled_ext(spr_static, current_time / 50, 0, 0, 1, 1, c_black, 0.7);
}

var _gameW;

if (global.playground)
    _gameW = 1920;
else
    _gameW = 1408;

var _x = (_gameW / 2) + xoff;
var _y = 540 + yoff;
var _xscale = box_xscale[frame];
var _yscale = box_yscale[frame];
var _angle = 0;

if (box)
{
    draw_sprite_ext(spr_paused, 0, _x, _y, _xscale, _yscale, _angle, c_white, 1);
    draw_sprite_ext(spr_paused, paused_ind, _x, _y, _xscale, _yscale, _angle, c_white, 1 + (sin(current_time / 270) * 0.3));
}

var _barX = _x + 9;

if (ready)
{
    draw_set_font(obj_persistent.font_pixel);
    var _yy = _y - 45;
    var _sep = 94;
    var _scale_normal = 2.2;
    var _scale_selected = 2.5;
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    for (var i = 0; i < options_draw_max; i++)
    {
        var _str;
        
        if (i > (array_length(options) - 1))
            _str = "";
        else
            _str = options[i];
        
        var _w = string_width(_str);
        var _h = string_height(_str);
        var _barScale, _yoff;
        
        if (selected == i)
        {
            var _scale = _scale_selected;
            _yoff = 0;
            _angle = 0;
            _barScale = 1.07;
        }
        else
        {
            var _scale = _scale_normal;
            _yoff = 0;
            _angle = 0;
            _barScale = 1;
        }
        
        var _squeeze;
        
        if (i == 2)
            _squeeze = 0.95;
        else
            _squeeze = 1;
        
        var _ind, _shakeX, _shakeY;
        
        if (i == 1 && object_index == obj_title_menu && options[i] != "???")
        {
            _ind = 1 + global.bside;
            var _amnt = 8;
            _shakeX = irandom_range(-_amnt, _amnt) * bar_shake;
            _shakeY = irandom_range(-_amnt, _amnt) * bar_shake;
            glyph_shakeX = _shakeX;
            glyph_shakeY = _shakeY;
        }
        else
        {
            _shakeX = 0;
            _shakeY = 0;
            _ind = 0;
        }
        
        draw_sprite_ext(spr_paused_bar, _ind, _barX + _shakeX, _yy + _shakeY, _barScale, _barScale, 0, c_white, 1);
        
        if (selected != i)
            draw_sprite_ext(spr_paused_bar, _ind, _barX + _shakeX, _yy + _shakeY, _barScale, _barScale, 0, c_black, 0.15);
        
        if (i > (array_length(options) - 1))
        {
            draw_sprite_ext(spr_paused_bar, _ind, _barX, _yy, _barScale, _barScale, 0, c_black, 0.5);
            _yy += _sep;
        }
        else
        {
            var _xx = _x + 10;
            var _scale;
            
            switch (_str)
            {
                case "WIZARD'S REVENGE":
                    _scale = _scale * 0.85;
                    break;
                
                case "RESOLUTION":
                    _str = $"RESOLUTION: {obj_persistent.resW[global.resolution]}X{obj_persistent.resH[global.resolution]}";
                    _scale = _scale * (13 / string_length(_str));
                    break;
                
                case "FULLSCREEN":
                    _str = string("FULLSCREEN: {0}", window_get_fullscreen() ? "ON" : "OFF");
                    _scale = _scale * (12.5 / string_length(_str));
                    break;
                
                case "COLORBLIND":
                    _str = string("COLORBLIND: {0}", global.colorblind ? "ON" : "OFF");
                    _scale = _scale * (13 / string_length(_str));
                    break;
                
                case "VSYNC":
                    _str = string("VSYNC: {0}", global.vsync ? "ON" : "OFF");
                    break;
                
                case "MASTER":
                    _str = $"MASTER VOL: {global.master_vol * 100}%";
                    _scale = _scale * 0.83;
                    break;
                
                case "BGM":
                    _str = $"BGM VOL: {global.bgm_vol * 100}%";
                    break;
                
                case "SFX":
                    _str = $"SFX VOL: {global.sfx_vol * 100}%";
                    break;
                
                case "VOICE":
                    _str = string("VOICE CLIPS: {0}", global.voice_clips ? "ON" : "OFF");
                    _scale = _scale * (13 / string_length(_str));
                    break;
                
                case "REMAP KEYBOARD":
                    _scale = _scale * 0.85;
                    break;
                
                case "PAD DEADZONE":
                    var _dz = (global.deadzone == 0) ? "LOW" : ((global.deadzone == 1) ? "NORMAL" : "HIGH");
                    _str = $"PAD DEADZONE: {_dz}";
                    var _s = (global.deadzone == 0) ? 0.72 : ((global.deadzone == 1) ? 0.62 : 0.7);
                    _scale = _scale * (13 / string_length(_str));
                    break;
                
                case "RESET PAD DEFAULT":
                    _scale = _scale * 0.75;
                    break;
                
                case "DELETE SAVE DATA":
                    _scale = _scale * 0.825;
                    break;
            }
            
            if (!(object_index == obj_title_menu && instance_exists(obj_options)))
            {
                draw_text_transformed(_xx + _shakeX, _yy + _yoff + 5 + _shakeY, _str, _scale * _squeeze, _scale, _angle);
                
                if (selected != i)
                    draw_sprite_ext(spr_paused_bar, _ind, _barX + _shakeX, _yy + _shakeY, _barScale, _barScale, 0, c_black, 0.2);
            }
            
            _yy += _sep;
        }
    }
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
