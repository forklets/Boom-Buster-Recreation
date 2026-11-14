screen_shake(3, 3);
grav = 1.2;

if (toggle_pause)
{
    var _paused = obj_controller.bridget_pause;
    
    if (_paused)
    {
        with (obj_controller)
            event_bridget_unpause();
    }
    else
    {
        with (obj_controller)
            bridget_pause = true;
    }
}
