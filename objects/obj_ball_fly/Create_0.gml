event_inherited();
has_collision = false;
grav = 0;
hspd = 0;
stompable = false;
spinnable = true;
sprite_spun = spr_ball_fly_death;
go = false;
timer[0] = 30;

timer_func[0] = function()
{
    go = true;
    anim_play(spr_ball_fly);
};

spd = 0;

if (instance_exists(obj_player))
{
    if (obj_player.x < x)
        facing = -1;
    else
        facing = 1;
}

y -= 32;
