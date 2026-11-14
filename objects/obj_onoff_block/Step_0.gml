event_inherited();
pal_ind = global.onoff_colors[global.onoff] + 1;

if (global.onoff == 0)
    screen_spr = spr_on;
else if (global.onoff == 1)
    screen_spr = spr_off;
else if (global.onoff == 2)
    screen_spr = spr_cat;

if (keyboard_check_pressed(vk_space) && global.debug)
    event_user(0);
