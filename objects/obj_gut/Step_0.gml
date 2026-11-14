while (place_meeting(x, y, obj_solid))
    y--;

physics_apply();
anim_logic();
angle += (hspd * 1.25);

if (on_ground())
    hspd = approach(hspd, 0, 0.075);
