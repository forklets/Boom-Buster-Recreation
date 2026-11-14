if (sink)
    y_sink += 2.5;

shake = approach(shake, 0, 0.08333333333333333);
timer_logic(0);

if (hit_wait)
{
    hit_wait--;
    
    if (hit_wait == 0)
    {
        sink = true;
        timer[0] = 2;
        audio_sound_gain(snd_explosion, 0.3, 1500);
        
        if (room == rm_outskirts_3 || room == rm_outskirts_b3)
            audio_sound_gain(global.bgmPlay, 0, 800);
        else if (!array_contains(global.stages_outskirts, room))
            audio_sound_gain(global.bgmPlay, 0, 800);
    }
}
