var _boxW = sprite_get_width(spr_title_box);

draw_buster = function()
{
    draw_set_bounds(0, 0, 1920 - sprite_get_width(spr_title_box), 1080);
    var _xoff = 0;
    
    if (buster_spr == spr_title_buster_walk && buster_facing == 1)
        _xoff = -30;
    
    var _walkYoff;
    
    if (walk)
        _walkYoff = (sin(current_time / 80) * 6) + 6;
    else
        _walkYoff = 0;
    
    var _yoff = 0;
    
    if (bom_down)
        _yoff = bom_hand_yoff;
    
    var _scale = 1;
    var _darken = 0;
    
    if (cartwheel)
    {
        _scale = 0.775;
        _darken = 0.06;
    }
    
    draw_sprite_ext(buster_spr, buster_ind, buster_x + _xoff, buster_y + _walkYoff + _yoff, _scale * buster_xscale * buster_facing, _scale * buster_yscale, buster_angle, c_white, 1);
    draw_sprite_ext(buster_spr, buster_ind, buster_x + _xoff, buster_y + _walkYoff + _yoff, _scale * buster_xscale * buster_facing, _scale * buster_yscale, buster_angle, c_black, _darken);
    draw_reset_clip();
};

if (!surface_exists(surf))
    surf = surface_create(1920, 1080);

surface_set_target(surf);
draw_clear_alpha(c_white, 0);

if (cartwheel)
    draw_buster();

gpu_set_texfilter(false);
var _scale = logo_scale * logo_scale_beat;
var _x = logo_x;
var _y = logo_y;
draw_sprite_ext(spr_logo, 0, _x, _y, _scale, _scale, 0, c_white, 1);
gpu_set_texfilter(global.texfilter);

if (!cartwheel)
    draw_buster();

if (bom_in)
    draw_sprite_ext(spr_title_buster_crazy_hand, buster_ind, buster_x, buster_y + bom_hand_yoff, buster_xscale * buster_facing, buster_yscale, buster_angle, c_white, 1);

draw_sprite_ext(spr_title_buster_wizard, buster_ind, (left_width / 2) - 65, 1080 + wizard_yoff, 1, 1, 0, c_white, 1);
_x = (1920 - _boxW) + box_x;
var _ind = 0;

if (instance_exists(obj_roundselect))
    _ind = 1;

if (instance_exists(obj_theater))
    _ind = 2;

draw_sprite(spr_title_box, _ind, _x, 0);
surface_reset_target();
draw_surface(surf, 0, 0);
var _new_game = true;

if (_new_game)
    new_game_yoff = -18;
else
    new_game_yoff = 0;

draw_set_font(obj_persistent.font_pixel_outline);

if (!instance_exists(obj_roundselect) && !instance_exists(obj_options) && !instance_exists(obj_title_extras) && !_new_game)
{
    draw_set_alpha(0.55);
    draw_set_halign(fa_center);
    _x = 1435 + box_x;
    _y = 207;
    _scale = 2;
    var _yoff = 0;
    
    if (obj_title_menu.selected == 0)
        _yoff -= 2;
    
    var _str;
    
    if (_new_game)
        _str = "NEW GAME";
    else
        _str = $"CONTINUE: ROUND {_round}";
    
    if (global.bside)
        _str += "B";
    
    draw_text_transformed(_x, _y + _yoff, _str, _scale, _scale, 0);
    draw_set_halign(fa_left);
    draw_set_alpha(1);
}

if (!instance_exists(obj_roundselect) && !instance_exists(obj_theater))
{
    if (instance_exists(obj_title_menu) || instance_exists(obj_title_extras))
        event_user(1);
    
    with (obj_title_newgame)
    {
        event_user(0);
        event_user(1);
    }
    
    if (!instance_exists(obj_title_extras) && !instance_exists(obj_title_newgame) && !instance_exists(obj_options))
    {
        with (obj_title_menu)
        {
            xoff = 729 + other.box_x;
            yoff = (-215 + other.new_game_yoff) - 35 - 25;
            yoff += 37;
            event_user(1);
        }
        
        if (global.save.campaign_beat_A)
        {
            _scale = 0.8;
            _x = 1128;
            _y = 307;
            _x += 128;
            
            if (obj_title_menu.selected == 1)
            {
                _x -= 14;
                _scale += 0.04;
                _y -= 2;
            }
            
            _x += obj_title_menu.glyph_shakeX;
            _y += obj_title_menu.glyph_shakeY;
            draw_glyph(global.input_menu_special_glyph, _x + box_x, _y, _scale, 1);
        }
    }
}

with (obj_achievements)
    event_user(0);

with (obj_results)
    event_user(0);

with (obj_roundselect)
    event_user(0);

if (!instance_exists(obj_achievements))
{
    with (obj_title_extras)
    {
        yoff = -208;
        yoff += 56;
        event_user(0);
        event_user(1);
    }
}

with (obj_theater)
{
    yoff = -325;
    event_user(0);
    event_user(1);
}

if (instance_exists(obj_options))
{
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_rectangle(0, 0, 1920, 1080, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}

if (instance_exists(obj_howtoplay))
{
    with (obj_howtoplay)
        event_user(1);
}
else
{
    with (obj_options)
        event_user(1);
}
