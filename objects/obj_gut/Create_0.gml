physics_init();
anim_init();

event_floor = function()
{
    if (vspd > 0)
    {
        vspd = -vspd * 0.7;
        
        if (vspd > -2)
            vspd = 0;
    }
};

event_wall = function()
{
    hspd = -hspd;
};

angle = 0;
facing = 1;
yoff = 0;
palettes = [pal_buster, pal_bridget];
player = 0;
char = 0;
