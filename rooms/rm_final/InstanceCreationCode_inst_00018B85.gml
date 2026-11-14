event_bounce = function()
{
    with (obj_controller)
        event_final_jello();
    
    if (global.players >= 2)
    {
        obj_player.x = x - 64;
        obj_player2.x = x + 64;
        par_player.y = bbox_top - 3;
    }
};
