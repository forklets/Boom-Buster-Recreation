if (exit_freeze() || !instance_exists(obj_player))
    exit;

if (voice_wait)
    voice_wait--;

if (place_meeting(x, y, obj_explosion_radius))
{
    if (audio_is_playing(voice_play_ow))
        audio_stop_sound(voice_play_ow);
    
    if (!voice_wait)
    {
        voice_play_ow = audio_play_sound(voices_ow[ow_index], 0, false);
        ow_index++;
        
        if (ow_index > (array_length(voices_ow) - 1))
            ow_index = 0;
        
        voice_wait = 7;
    }
    
    with (obj_controller)
        channel = 0;
    
    if (timer[1] == -1 && !hits_last)
        timer[1] = 120;
    
    if (hits_last && state != 2)
    {
        obj_player.deac_allow_spin = false;
        state = 2;
        anim_play(spr_wizard_final_dead);
        timer[2] = 120;
    }
    
    prompt = false;
}

if (instance_exists(obj_player))
{
    if (obj_player.y <= (obj_cam_final_maxY.y - 64))
    {
        obj_player.facing = -1;
        obj_player.x = 1056;
        
        if (global.players >= 2)
        {
            obj_player2.x = 1120;
            obj_player2.facing = -1;
        }
        
        obj_controller.final_ended = true;
    }
}

var _grounded = false;

with (obj_player)
    _grounded = on_ground();

if (obj_controller.final_ended && _grounded && state == 0)
{
    if (timer[0] == -1)
        timer[0] = 30;
}

timer_logic(0);
timer_logic(1);
timer_logic(2);
anim_logic();

if (prompt)
{
    prompt_alpha = approach(prompt_alpha, 1, 1/15);
    prompt_swap_delay--;
    
    if (prompt_swap_delay == 0)
    {
        prompt_swap_delay = prompt_swap_delay_count;
        prompt_ind = !prompt_ind;
    }
}
else
{
    prompt_alpha = approach(prompt_alpha, 0, 0.1);
}

var _array = instance_place_array(x, y, obj_explosion_radius);

for (var i = 0; i < array_length(_array); i++)
{
    if (i == 0)
    {
        anim_sprite = spr_wizard_final_ow;
        anim_index++;
        anim_speed = 0;
    }
    
    hit_count++;
    
    with (obj_coin)
        instance_destroy();
    
    with (obj_score)
        instance_destroy();
    
    var _coin = instance_create_layer(x, y - 192, "Instances_Over", obj_coin);
    
    with (_coin)
    {
        worth = 1;
        event_user(0);
    }
    
    instance_destroy(_array[i]);
}

if (hit_count > 0)
{
    with (obj_score)
        amount = other.hit_count;
}
