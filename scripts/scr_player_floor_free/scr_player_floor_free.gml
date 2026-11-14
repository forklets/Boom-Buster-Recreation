function scr_player_floor_free()
{
    bounce = false;
    var _crate = instance_place(x, y + 1, obj_crate);
    
    if (_crate && _crate.jumpable)
    {
        with (_crate)
            event_break();
        
        if (jumps == 2)
            jumps = 1;
        
        dashed = false;
        bounce_blocks_hold = 2.75;
        bounce_blocks = 1.5;
        var _input = (global.players > 1) ? input_check : input_check_all;
        
        if (_input("jump", player))
            vspd = -calculate_jump(bounce_blocks_hold, grav);
        else
            vspd = -calculate_jump(bounce_blocks, grav);
        
        exit;
    }
    
    if (state == state_hurt)
    {
        vspd = 0;
        exit;
    }
    
    if (crouch_input && (action == action_free || action == action_backflip || action == action_spin))
    {
        var _action = action;
        
        if (_action == action_spin)
        {
            action = action_crouch_spin;
        }
        else
        {
            if (hspd == 0)
            {
                anim_sprite = spr_buster_crouch;
                anim_index = 2;
            }
            else
            {
                anim_play(spr_buster_crouchwalk);
            }
            
            action = action_crouch;
            event_squish(squish_crouch);
        }
    }
    
    if (action == action_backflip)
        hspd = 0;
    
    event_squish(squish_land);
    
    if (!land_anim_delay)
    {
        if (ds_list_size(list_carry) == 0 && (action == action_free || action == action_backflip) && land_animation)
            override_play(spr_buster_land);
        
        if (action == action_slam)
        {
            hspd = 0;
            screen_shake(12, 12, 1);
            part_particles_create(global.part_over, x, y, global.particles.dustland, 1);
        }
        else
        {
            audio_play_sound(snd_land, 0, 0);
            
            if (dust_land && !place_meeting(x, y + 1, obj_spike))
                event_dust();
        }
    }
    
    slam_bounce = false;
    
    if (action == action_slam)
    {
        if (crouch_input)
        {
        }
        else
        {
            vspd = -slam_strength;
            slam_bounce = true;
            jumps = 2;
        }
        
        action = action_free;
    }
    
    if (!slam_bounce)
        vspd = 0;
}
