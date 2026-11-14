if (!surface_exists(surf))
    surf = surface_create(1920, 1080);

surface_set_target(surf);

if (sprite_exists(spr))
{
    gpu_set_blendenable(false);
    draw_sprite(spr, 0, 0, 0);
    gpu_set_blendenable(true);
}

with (obj_controller)
{
    gpu_set_blendenable(false);
    draw_surface(surf_gui, 0, 0);
    gpu_set_blendenable(true);
}

var _col = 0;
var _alpha = 0.65;
draw_set_alpha(_alpha);
draw_rectangle_color(0, 0, 1920, 1080, _col, _col, _col, _col, false);
draw_set_alpha(1);

if (!global.playground)
{
    with (obj_controller)
    {
        draw_dollars();
        draw_bombcounter();
    }
}

if (instance_exists(obj_howtoplay))
{
    with (obj_howtoplay)
        event_user(1);
}
else if (instance_exists(obj_options))
{
    with (obj_options)
        event_user(1);
}
else if (instance_exists(obj_achievements))
{
    with (obj_achievements)
        event_user(0);
}
else if (!instance_exists(obj_multiplayer))
{
    event_user(1);
}

if (!instance_exists(obj_multiplayer) && !instance_exists(obj_achievements) && !(instance_exists(obj_options) && obj_options.menu_selected.menu == "remap") && !instance_exists(obj_howtoplay))
{
    if (little_buster_go)
    {
        var _scale = 4;
        draw_sprite_ext(buster_spr, buster_ind, buster_x, buster_y, buster_facing * _scale, _scale, 0, c_white, 1);
    }
}

surface_reset_target();
gpu_set_blendenable(false);
draw_surface(surf, 0, 0);
gpu_set_blendenable(true);

if (ready && !global.playground && !global.round_select && !instance_exists(obj_options) && !instance_exists(obj_achievements) && !array_contains(global.stages_final, room))
{
    var _str = "ADD PLAYER";
    
    if (global.players > 1)
        _str = "REMOVE PLAYER";
    
    var _x;
    
    if (global.playground)
        _x = 960;
    else
        _x = 704;
    
    _x -= 158;
    _x = 130;
    var _y = 1030;
    _y = 28;
    var _scale = 2.25;
    draw_set_font(obj_persistent.font_pixel_outline);
    draw_text_transformed(_x, _y, _str, _scale, _scale, 0);
    draw_glyph(global.input_menu_special_glyph, _x - 100, _y - 12, 0.9, 0.9);
}
