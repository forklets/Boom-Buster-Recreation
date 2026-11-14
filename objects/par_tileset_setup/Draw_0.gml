draw_set_font(fnt_adlib);

for (var i = 0; i < (room_width / 64); i++)
{
    for (var j = 0; j < (room_height / 64); j++)
    {
        var _column = ((i * 64) div 64) + ((room_width / 64) * j);
        var _x = i * 64;
        var _y = j * 64;
        
        if (collision_rectangle(_x, _y, _x + 64, _y + 64, obj_footstep_grass, true, true))
            draw_set_color(c_lime);
        else if (collision_rectangle(_x, _y, _x + 64, _y + 64, obj_footstep_metal, true, true))
            draw_set_color(c_red);
        
        draw_text_transformed(i * 64, j * 64, _column, 0.2, 0.2, 0);
        draw_set_color(c_white);
    }
}
