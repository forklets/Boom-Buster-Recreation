if (instance_exists(obj_bonus_controller) && obj_bonus_controller.time <= 0)
    exit;

if (exit_freeze())
    exit;

if (instance_exists(obj_player_death))
    exit;

if (!landed && !tossed)
{
    var _cage = instance_place(x, y, obj_bom_cage);
    
    if (_cage && !instance_exists(_cage.bom_inside) && _cage.y == landY)
    {
        _cage.bom_inside = id;
        _cage.col = col;
        caged = true;
        
        with (_cage)
            event_user(0);
    }
}

anim_logic();
sprite_index = anim_sprite;
image_index = anim_index;

if (limited_life && !tossed)
{
    life--;
    
    if (life <= 150 && flicker_animation)
    {
        if (timer[2] == -1)
            timer[2] = 4;
        
        if (flicker)
            image_alpha = 0.9;
        else
            image_alpha = 0.3;
        
        if (life <= 0)
        {
            part_particles_create(global.part_over, x, y, global.particles.smoke, 1);
            instance_destroy();
        }
    }
    
    timer_logic(2);
}
else
{
    image_alpha = 1;
}

if (wings)
{
    wings_sin = sin(time) * 3;
    time += 0.2;
    wing_ind += 0.35;
    
    if (mypath == noone)
    {
        y = lerp(y, landY, 0.1);
        
        if (y <= (landY - 64))
            has_collision = false;
        else
            landed = true;
        
        exit;
    }
}

if (thrown && place_meeting(x, y, par_enemy))
    event_impact();

if (inPipe)
{
    if (!has_collision)
        x = lerp(x, inPipe.x + 128, 0.2);
    
    if (y >= (inPipe.y + 100))
        has_collision = true;
    
    x += hspd;
    y += vspd;
    
    if ((hspd > 0 && bbox_right > ((inPipe.boxX + 256 + hspd) - 28)) || (hspd < 0 && bbox_left < (inPipe.boxX + hspd + 28)))
        event_wall();
    
    if (vspd > 0 && y > (inPipe.boxY + 165 + vspd))
    {
        y = inPipe.boxY + 165;
        event_floor();
    }
    
    vspd += grav;
    exit;
}

if (throwable)
{
    timer_logic(1);
    
    if (!thrown)
        hspd = approach(hspd, 0, 0.5);
}

if (mypath != noone && !on_path && y >= (landY + path_yoff))
{
    on_path = true;
    x = path_get_x(mypath, path_pos);
    y = path_get_y(mypath, path_pos);
}

path_follow();

if (landYobj != noone)
    landY = landYobj.y - 2;

if (y < landY)
    has_collision = false;
else
    landed = true;

if (landed && !thrown && (place_meeting(x, y + 1, obj_spike) || place_meeting(x, y + 1, obj_buzzsaw)) && !tossed)
{
    if (place_meeting(x, y + 1, obj_spike) && instance_exists(obj_player_death))
    {
    }
    else
    {
        vspd = -23;
    }
}

if (ignore != noone && instance_exists(ignore))
{
    if (ds_list_size(ignore.list_carry) > 0 && ds_list_find_value(ignore.list_carry, 0).col != col)
    {
        ignore_timer = 0;
        ignore = noone;
    }
}

if (ignore_timer)
{
    ignore_timer--;
    
    if (ignore_timer == 0)
    {
        if (place_meeting(x, y, ignore))
            ignore_timer = 15;
        else
            ignore = noone;
    }
}

if (carried == noone)
{
    if (!solid_meeting(x, y, obj_solid))
        has_gravity = true;
    
    physics_apply();
    hspd_bounce = approach(hspd_bounce, 0, 0.1);
    
    if (!throwable && inPipe == noone && place_meeting(x, y, obj_pipe) && landed && tossed)
    {
        var _pipe = instance_place(x, y, obj_pipe);
        
        if (_pipe.col == col || col == 21)
        {
            if (pipe_add_bom)
            {
                var _num;
                
                with (_pipe)
                {
                    _num = array_length(boms);
                    
                    if (_num >= 12)
                        _num--;
                    
                    boms[_num] = {};
                }
                
                _pipe.boms[_num].x = x;
                _pipe.boms[_num].y = y;
                _pipe.boms[_num].hspd = irandom_range(2.5, 4) * choose(-1, 1);
                _pipe.boms[_num].vspd = 20;
            }
            
            pipe_entered = _pipe;
            event_user(1);
            
            with (_pipe)
            {
                player = other.player;
                bonus_score += other.worth;
                event_user(0);
            }
            
            instance_destroy();
            exit;
        }
        
        if (!hammered)
        {
            event_explode();
            
            with (obj_bom_explode_anim)
                my_pipe = _pipe;
        }
    }
}
else
{
    ignore = noone;
    ignore_timer = 0;
    hspd = 0;
    hspd_bounce = 0;
    vspd = 0;
}

if (vspd > 26)
    vspd = 26;

if (tossed)
    grav = 1.5;

flash_nuclear_alpha = approach(flash_nuclear_alpha, 0, 1/15);
