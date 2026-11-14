if (global.auto_scroller)
{
    wings = true;
    get_cams(0);
    x = (camx + xstart) - 96;
    y = camy + ystart;
}

with (pipe_bg)
{
    x = other.x;
    y = other.y + other.wings_sin;
    image_index = other.col;
}
