event_user(0);
global.round_select = instance_exists(obj_roundselect);

if (!global.round_select)
{
    global.round_select_menu = 0;
    global.round_select_selected = 0;
}

if (!instance_exists(obj_theater))
    global.theater = noone;

if (box_in)
    box_percent = approach(box_percent, 1, 0.016666666666666666);

box_x = use_curve(acurv_basics, box_percent, "ease_inout", 950, 0);
bg_x = use_curve(acurv_basics, box_percent, "ease_inout", 0, -475);
logo_scale = use_curve(acurv_basics, box_percent, "ease_inout", 0.45, 0.22);
logo_x = use_curve(acurv_basics, box_percent, "ease_inout", 960, 485);
logo_y = use_curve(acurv_basics, box_percent, "ease_inout", 390, 182);
copyright_alpha = use_curve(acurv_basics, box_percent, "ease_inout", 1, -1.5);

if (!start && (input_check_pressed_all_any() || keyboard_check_pressed(vk_anykey)))
{
    start = true;
    audio_play_sound(snd_kaching, 0, false);
    timer[2] = 60;
    timer[3] = timer[2] + 43;
    start_flash = false;
    timer[4] = start_flash_delay;
}

timer_logic(2);
timer_logic(3);
timer_logic(4);

if (!start || !start_done)
    exit;

timer_logic(0);
timer_logic(1);

if (go)
    exit;

if (!instance_exists(obj_options) && !instance_exists(obj_achievements) && !instance_exists(obj_results) && !instance_exists(obj_roundselect) && !instance_exists(obj_title_extras) && !instance_exists(obj_theater))
{
    with (obj_title_menu)
    {
        event_user(0);
        
        if (input_check_pressed_all(global.input_menu_special) && global.save.campaign_beat_A)
        {
            selected = 1;
            options_event[1]();
        }
    }
}

buster_ind += (sprite_get_speed(buster_spr) / 60);

if (buster_ind >= sprite_get_number(buster_spr))
{
    buster_ind -= buster_ind;
    event_buster_animend();
}

if (pause)
{
    pause--;
}
else
{
    if (array_length(timeline) > 0 && timeline_pos < array_length(timeline))
        timeline[timeline_pos]();
    
    timeline_pos++;
}

if (global.debug)
{
    if (keyboard_check_pressed(ord("0")))
        event_buster_anim_idle();
    
    if (keyboard_check_pressed(ord("1")))
        event_buster_anim_look();
    
    if (keyboard_check_pressed(ord("2")))
        event_buster_anim_smug();
    
    if (keyboard_check_pressed(ord("3")))
        event_buster_anim_crazy();
    
    if (keyboard_check_pressed(ord("4")))
        event_buster_anim_zoomies();
    
    if (keyboard_check_pressed(ord("5")))
    {
        walk_facing = choose(1, -1);
        event_buster_anim_walk();
    }
    
    if (keyboard_check_pressed(ord("6")))
    {
        walk_facing = 1;
        event_buster_anim_cartwheel();
    }
    
    if (keyboard_check_pressed(ord("7")))
    {
        walk_facing = choose(-1, 1);
        event_buster_anim_walkaway();
    }
}

if (buster_spr == spr_title_buster)
    timer_logic(5);
else
    timer[5] = cycle_time;

if (bom_rise)
    bom_hand_yoff = use_curve(acurv_basics, bom_percent, "ease_inout", bom_hand_yoff_max, 0);
else
    bom_hand_yoff = use_curve(acurv_basics, bom_percent, "ease_inout", 0, bom_hand_yoff_max + 300);

bom_percent = approach(bom_percent, 1, 0.014285714285714285);

if (wizard_rise_anim)
    wizard_yoff = use_curve(acurv_basics, wizard_percent, "ease_inout", wizard_yoff_max, 0);
else
    wizard_yoff = use_curve(acurv_basics, wizard_percent, "ease_inout", 0, wizard_yoff_max + 300);

wizard_percent = approach(wizard_percent, 1, 0.007692307692307693);
buster_vspd += buster_grav;
buster_y += buster_vspd;
buster_x += buster_hspd;

if (launch)
    buster_angle -= 2;

if (cartwheel)
    buster_angle += 4.5;

if (walk)
{
    buster_x = approach(buster_x, buster_xto, 7);
    
    if (buster_x == buster_xto)
    {
        var _away = walk_away;
        
        if (_away)
        {
            walk_facing = -walk_facing;
            event_buster_anim_walk();
            timeline[0]();
        }
        else
        {
            event_buster_reset();
        }
    }
}
