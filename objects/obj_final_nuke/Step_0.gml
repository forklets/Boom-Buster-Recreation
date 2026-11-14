anim_logic();
y += vspd;
var _ground = instance_place(x, y + 1, par_ground);

if (_ground && vspd > 1)
{
    y = _ground.y;
    vspd = 0;
    event_user(1);
}

timer_logic(0);
timer_logic(1);
