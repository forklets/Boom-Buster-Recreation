bonus_freeze = false;
anim_init();
facing = 1;
facing_lock = false;
dies_on_spikes = true;
path_init();
path_lock_timer = -1;
scr_init_eyetrack();
invincible = false;
stompable = true;
spinnable = true;
can_die_stomp = true;
can_die_spin = true;
walkspd = 2;
alarm[0] = 1;
ledge_turn = false;
mask_normal = mask_index;
mask_hurt = noone;
sprite_turn = noone;
sprite_move = sprite_index;
hurt_delay = 0;
hurt_player = noone;
stomped = false;
spun = false;
physics_init();
vspd_max = 16;

event_wall = function()
{
    if (place_meeting(x + sign(hspd), y, obj_solid))
        hspd = -hspd;
};

event_animend_extra = function()
{
};

event_animend = function()
{
    var _anim = anim_sprite;
    
    if (_anim == sprite_turn)
        anim_play(sprite_move);
    
    event_animend_extra();
};

event_ymove = function()
{
    var _player = instance_place(x, y - 1, obj_player);
    
    if (vspd < 0 && _player)
    {
        with (_player)
        {
            var _enemy = instance_place(x, y + 1, par_enemy);
            
            if (_enemy && _enemy.stompable && y <= (_enemy.bbox_top + 4))
            {
                with (_enemy)
                {
                    hitBy = other;
                    hurt_delay = 10;
                    event_user(0);
                }
                
                while (place_meeting(x, y + 10, _enemy))
                    y--;
                
                event_bounce_enemy();
            }
        }
    }
    
    return true;
};

hspd_bounce = 0;
angle = 0;
