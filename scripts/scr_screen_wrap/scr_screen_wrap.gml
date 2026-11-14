function scr_screen_wrap()
{
    if (x > room_width)
        x -= room_width;
    
    if (x < 0)
        x += room_width;
}
