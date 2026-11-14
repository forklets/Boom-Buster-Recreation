if (!instance_exists(id))
    exit;

zoom = obj_controller.zoom;
var _zoom = 1 - (zoom - 1);
get_cams();

if (!surface_exists(surf))
    surf = surface_create(1920, 1080);

surface_set_target(surf);
draw_set_color(c_black);
draw_rectangle(0, 0, 1920, 1080, false);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(obj_persistent.font_pixel);
var _str = "UNDEFINED";

if (room == rm_bonus_1 || room == rm_bonus_2 || room == rm_bonus_3 || room == rm_bonus_b1 || room == rm_bonus_b2 || room == rm_bonus_b3)
{
    var _round = scr_get_bonus(room);
    var _b;
    
    if (global.bside)
        _b = "B";
    else
        _b = "";
    
    _str = $"BONUS {_round + 1}{_b}";
}
else
{
    var _round = global.round;
    
    if (array_contains(global.stages_tutorial, room))
        _str = $"TUTORIAL {_round + 1}";
    else if (room == rm_final_scroll)
        _str = "FINAL ROUND";
    else if (room == rm_final_scroll_b)
        _str = "THE WIZARD'S REVENGE";
    else if (global.bside)
        _str = $"ROUND {_round + 1}B";
    else
        _str = $"ROUND {_round + 1}";
}

draw_text_shake(960, 480, _str, 0.5, 4, 4);

if (display_act)
{
    var _name = string_upper(global.act_name);
    var _xscale;
    
    if (room == rm_outskirts_b3)
        _xscale = 3.55;
    else if (room == rm_round_b18 || room == rm_round_b20)
        _xscale = 3.9;
    else if (string_length(_name) >= 20)
        _xscale = 4.25;
    else
        _xscale = 6;
    
    draw_text_shake(960, 540 + (60 * display_act), $"{_name}", undefined, _xscale, 6);
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);

for (var i = 0; i < instance_number(obj_player); i++)
{
    var _inst = instance_find(obj_player, i);
    gpu_set_blendmode(bm_subtract);
    var _x = _inst.x - (camx * _zoom);
    var _y = _inst.y - (camy * _zoom);
    draw_circle(_x * _zoom, (_y - (40 * zoom)) * _zoom, (radius + radius_add) * _zoom, false);
    gpu_set_blendmode(bm_normal);
}

surface_reset_target();
draw_set_alpha(fade_alpha);
draw_surface(surf, global.app_xoff, 0);
draw_set_alpha(1);
