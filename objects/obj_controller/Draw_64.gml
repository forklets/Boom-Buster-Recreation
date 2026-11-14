tv_x = 1408;

if (!surface_exists(surf_gui))
    surf_gui = surface_create(1920, 1080);

surface_set_target(surf_gui);
var _w;

if (global.playground)
    _w = 1920;
else
    _w = 1408;

if (!instance_exists(obj_paused))
{
    if (!surface_exists(view_surf))
        view_surf = surface_create(_w, 1080);
    
    view_surface_id[0] = view_surf;
}

if (!instance_exists(obj_paused) && surface_exists(view_surf))
{
    gpu_set_blendenable(false);
    draw_surface(view_surf, 0, 0);
    gpu_set_blendenable(true);
}

if (instance_exists(obj_paused))
{
    with (obj_paused)
    {
        if (sprite_exists(spr))
            draw_sprite(spr, 0, 0, 0);
    }
}

draw_set_font(fnt_debug);
scr_tv_static();
scr_tv_bridget();
scr_tv_wizard();
var _x = 1920 - sprite_get_width(spr_ui_border);
var _y = 0;
draw_sprite_gui(spr_ui_meter_bg, 0, _x, _y);
draw_combometer();
draw_sprite_gui(spr_ui_border, tv_char, _x, _y);
draw_combometer_icon();
draw_dollars();
draw_bombcounter();

if (stage_event == "wizard" || array_contains(global.stages_final, room) || array_contains(global.stages_final_scroll, room))
    draw_wizardui();

if (stage_event == "bossfight")
    draw_bossui();

if (wizard_sprite == spr_tv_wizard_freak && channel == 2)
    draw_sprite_gui(wizard_sprite, wizard_sub, 1408, 0);

part_system_drawit(global.part_gui);

if (goodnight)
{
    gpu_set_texfilter(true);
    draw_set_color(c_black);
    draw_set_alpha(0.3);
    draw_rectangle(global.app_xoff, 0, global.app_xoff + 1920, 1080, false);
    draw_sprite_ext(spr_goodnight, 0, 704 - (global.screenshake[0] * 3), 540 - (global.screenshake[1] * 3), 1, 1, 0, c_white, 1);
    draw_set_alpha(1);
    draw_set_color(c_white);
    gpu_set_texfilter(false);
}

draw_set_alpha(flash_overlay);
draw_rectangle(global.app_xoff, 0, global.app_xoff + 1920, 1080, false);
draw_set_alpha(1);

if (global.playground && surface_exists(view_surf))
{
    gpu_set_blendenable(false);
    draw_surface(view_surf, 0, 0);
    gpu_set_blendenable(true);
}

with (obj_round_clear_select)
{
    draw_set_alpha(0.55);
    draw_rectangle_color(0, 0, 1920, 1080, c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
    event_user(1);
}

with (obj_round_clear)
    event_user(0);

surface_reset_target();
var _xscale = 1;
var _yscale = 1;
gpu_set_blendenable(false);
draw_surface(surf_gui, 0, 0);
gpu_set_blendenable(true);

if (room == rm_bonus_1 || room == rm_bonus_2 || room == rm_bonus_3 || room == rm_bonus_b1 || room == rm_bonus_b2 || room == rm_bonus_b3)
{
    with (obj_bonus_controller)
        event_user(0);
}
