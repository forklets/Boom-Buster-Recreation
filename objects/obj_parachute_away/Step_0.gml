if (exit_freeze())
    exit;

anim_logic();
vspd -= 0.2;

if (vspd < -7)
    vspd = -7;

x += hspd;
y += vspd;
