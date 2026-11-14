if (!global.died)
{
    global.deaths++;
    global.died = true;
}

anim_init();
alarm[5] = 1;
restart_delay = 0;
shake_strength = 1;
shake_dec = 0.08;

if (array_contains(global.bonus_rooms, room))
    timer[0] = -1;
else
    timer[0] = 40;

timer_func[0] = function()
{
    vspd = -12;
    grav = 0.95;
};

vspd = 0;
grav = 0;
facing = 1;
