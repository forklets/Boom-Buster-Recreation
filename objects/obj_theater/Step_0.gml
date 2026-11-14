event_inherited();

if (!gone && my_room != noone)
{
    if (!array_contains(global.save.cutscenes_watched, options[selected]))
    {
        audio_stop_play(snd_wrong, 0, false);
    }
    else
    {
        gone = true;
        deac = true;
        global.theater = selected;
        var _trans = room_goto_triangles(my_room, 60);
        global.bside = bside;
        audio_stop_all();
        audio_stop_play(snd_kaching, 0, false);
    }
    
    my_room = noone;
}

if (deac)
    exit;

if (input_check_pressed_all("spin") || input_check_pressed_all("back"))
{
    input_verb_consume_all("spin");
    input_verb_consume_all("back");
    event_back();
}
