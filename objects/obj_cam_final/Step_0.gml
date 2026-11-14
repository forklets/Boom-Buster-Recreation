if (!touched)
{
    var _player = instance_place(x, y, obj_player);
    
    if (_player && _player.state == _player.state_cannon)
    {
        with (obj_controller)
        {
            cam_go = false;
            cam_final = true;
            cam_final_yoff = y - obj_player.y;
        }
        
        touched = true;
    }
}
