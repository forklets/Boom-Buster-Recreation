if (instance_exists(obj_player_death) || obj_controller.win)
    exit;

with (obj_player)
{
    if (state != state_deac)
    {
        pit = true;
        timer[timer_pit] = 100;
        event_user(0);
        state = state_deac;
        pit_respawn_x = other.respawn_x;
        pit_respawn_y = other.respawn_y;
        
        if (global.invincible)
        {
            audio_play_sound(snd_losepowerup, 0, 0);
            global.combo_meter = 0;
            global.invincible = false;
        }
    }
}
