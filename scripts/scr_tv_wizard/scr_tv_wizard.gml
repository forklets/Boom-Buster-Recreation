function scr_tv_wizard()
{
    if (channel == 2)
    {
        draw_sprite_gui(spr_tv_bg_wizard, 0, 1408, 0);
        draw_sprite_gui(wizard_sprite, wizard_sub, 1408, 0);
        
        if (wizard_sprite == spr_tv_wizard_ouch && wizard_blink)
            draw_sprite_gui(spr_tv_wizard_ouch_eyes, wizard_sub, 1408, 0);
        
        draw_set_alpha(wizard_flash);
        draw_rectangle(global.app_xoff + 1408, 0, global.app_xoff + 1408 + 512, 386, false);
        draw_set_alpha(1);
    }
    
    wizard_flash = approach(wizard_flash, 0, 0.015);
    
    if (exit_freeze() && !tv_override)
        exit;
    
    wizard_sub += (wizard_speed * (sprite_get_speed(wizard_sprite) / 60));
    
    if (wizard_sub >= sprite_get_number(wizard_sprite))
        wizard_animend();
}
