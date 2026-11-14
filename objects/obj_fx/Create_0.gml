image_alpha_to = 1;
image_alpha_spd = 0.0375;
destroy = 0;
rotate_spd = 0;
hspd = 0;
vspd = 0;
grav = 0;
pal_sprite = noone;
pal_ind = 0;
pal_sub = 0;
anim_init();

event_animend = function()
{
    if (destroy == 0)
        instance_destroy();
};

bm = 0;
xscale_add = 0;
yscale_add = 0;
gui = false;
