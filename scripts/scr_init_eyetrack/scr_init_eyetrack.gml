function scr_init_eyetrack()
{
    eyes_sprite = noone;
    eyelids_sprite = noone;
    eyes_xoff = 0;
    eyes_yoff = 0;
    eyes_lenX = 6;
    eyes_lenY = 6;
    eyes_lenX_min = -999;
    eyes_lenX_max = -999;
    eyes_lenY_min = -999;
    eyes_lenY_max = -999;
    eyes_spr_xoff = 0;
    eyes_lag = 2;
    
    get_eyes = function()
    {
        var _y = y - 42;
        eX1 = x - (52 * facing);
        eY1 = _y - 316;
        eX2 = x + (396 * facing);
        eY2 = _y + 360;
    };
}
