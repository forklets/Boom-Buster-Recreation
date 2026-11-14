function scr_screen_wrap_draw(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
{
    for (var i = 0; i < 3; i++)
        draw_sprite_ext(arg0, arg1, (arg2 - room_width) + (room_width * i), arg3, arg4, arg5, arg6, arg7, arg8);
}
