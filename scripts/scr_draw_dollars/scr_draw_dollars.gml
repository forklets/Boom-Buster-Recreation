function scr_draw_dollars()
{
    var _spd;
    
    if ((global.dollars - dollars) >= 15)
        _spd = 0.5;
    else if ((global.dollars - dollars) >= 10)
        _spd = 0.35;
    else if ((global.dollars - dollars) <= 0.75)
        _spd = 0.03125;
    else
        _spd = 0.125;
    
    if (global.dollars < dollars)
        _spd = 0;
    
    if (!exit_freeze())
        dollars = approach(dollars, global.dollars, _spd);
    
    if (object_index != obj_roundselect)
    {
        if (dollars == global.dollars)
        {
            if (!dollars_flash)
                timer[timer_dollars_flash] = -1;
        }
        else if (!global.dollars < dollars)
        {
            if (timer[timer_dollars_flash] == -1)
                timer_func[timer_dollars_flash]();
        }
    }
    
    var _dy;
    
    if (display_highscore)
    {
        var _dbary = 803;
        _dy = 835;
    }
    else
    {
        var _dbary = 671;
        _dy = 708;
    }
    
    draw_set_font(obj_persistent.font_alarm);
    var _xscale;
    
    if (display_highscore)
    {
        if (dollars_flash && global.top_dollars < dollars)
            draw_set_color(#FFA366);
        else
            draw_set_color(c_red);
        
        var _dollars;
        
        if (dollars > global.top_dollars)
            _dollars = dollars;
        else
            _dollars = global.top_dollars;
        
        if (_dollars >= 10000)
            _xscale = 0.9;
        else
            _xscale = 1;
        
        _scale = 0.84;
        draw_text_transformed(1580 + global.app_xoff, 734, string_add_zeros(_dollars, 4, 2), _xscale * _scale * 0.95, _scale, 0);
    }
    
    if (dollars_flash)
        draw_set_color(#C8FFA3);
    else
        draw_set_color(#5ED10F);
    
    if (display_highscore)
        _angle = 0.8;
    else
        _angle = 1;
    
    var _angle = 0;
    
    if (dollars >= 10000)
        _xscale = 0.9;
    else
        _xscale = 1;
    
    var _scale = 0.84;
    draw_text_transformed(1569 + global.app_xoff + 6, _dy, string_add_zeros(dollars, 4, 2), _xscale * _scale, _scale, _angle);
    draw_set_color(c_white);
}
