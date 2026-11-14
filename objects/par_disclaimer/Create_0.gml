delay = 90;
timer[0] = 150;

timer_func[0] = function()
{
    if (object_index == obj_logo)
    {
        instance_create_layer(0, 0, "Transition", obj_explosion_hq);
        audio_play_sound(snd_explosion_title, 0, false);
    }
    else
    {
        room_goto_fade(my_room, delay);
    }
};
