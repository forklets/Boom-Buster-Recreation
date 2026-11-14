function scr_tv_static()
{
    if (channel == 0)
        draw_sprite_gui(spr_static, static_ind, tv_x, 0);
    
    if (exit_freeze() && !tv_override)
        exit;
    
    static_ind += (sprite_get_speed(spr_static) / 60);
    
    if (static_ind >= sprite_get_number(spr_static))
        static_ind -= static_ind;
}
