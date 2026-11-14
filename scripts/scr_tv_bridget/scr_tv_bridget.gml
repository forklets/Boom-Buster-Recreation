function scr_tv_bridget()
{
    if (channel == 1)
    {
        draw_sprite_gui(spr_tv_bg, tv_bg_ind, tv_x, 0);
        draw_sprite_gui(spr_tv_bag, 0, tv_x, 0);
        draw_sprite_gui(spr_tv_ground, tv_bg_ind, tv_x, 0);
        var _pal = [pal_bridget_tv, pal_buster_tv];
        var _num;
        
        if (global.players > 1)
            _num = 2;
        else
            _num = 1;
        
        pal_swap(_pal[!tv_char], 0, _num);
        draw_sprite_gui(bridget_sprite, bridget_sub, tv_x, 0);
        shader_reset();
        
        if (bridget_state == bridget_state_toss && bridget_sub <= 1)
            draw_sprite_gui(bridget_get("toss"), bridget_sub, tv_x, 0);
        
        if (bridget_sprite == tv_char_brb)
            draw_sprite_gui_ext(spr_static, static_ind, tv_x, 0, undefined, undefined, undefined, undefined, 0.2);
    }
    
    if (exit_freeze())
        exit;
    
    bridget_sub += (sprite_get_speed(bridget_sprite) / 60);
    
    if (bridget_sub >= sprite_get_number(bridget_sprite))
        bridget_animend();
}
