if (exit_freeze())
    exit;

image_alpha = easy_smooth(image_alpha, 0, 6.5);

if (image_alpha <= 0.05)
    instance_destroy();

x += hspd;
y += vspd;
vspd += grav;

if (vspd < -2)
    vspd = -2;

image_angle -= (hspd * 0.5);
