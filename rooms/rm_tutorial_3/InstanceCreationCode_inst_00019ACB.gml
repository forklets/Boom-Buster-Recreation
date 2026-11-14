type = type_ground;

event_trigger = function()
{
    with (obj_controls)
    {
        if (ID == 0)
            out = true;
        else if (ID == 1)
            event_user(0);
    }
    
    with (obj_tutorial_ghost)
        event_switch();
};
