if (go)
{
    scr_set_highscore();
    
    if (global.round_select)
    {
        with (obj_persistent)
            event_save();
    }
}
