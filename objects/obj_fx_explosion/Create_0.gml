bg = false;
loop_die = 3;
anim_init();

event_animend = function()
{
    anim_index = sprite_get_number(anim_sprite) - 1 - 2;
    loops++;
    
    if (loops == loop_die)
        out = true;
};

loops = 0;
scale = 1;
out = false;
timer[0] = -1;

timer_func[0] = function()
{
    scale -= 0.25;
};
