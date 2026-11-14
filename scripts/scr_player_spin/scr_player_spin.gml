function scr_player_spin()
{
    var _input = (global.players > 1) ? input_check : input_check_all;
    var _input_pressed = (global.players > 1) ? input_check_pressed : input_check_pressed_all;
    var _dropping = (_input("down", player) || _input("crouch", player)) && !place_meeting(x, y, obj_solid);
    
    if ((action == action_free || action == action_crouch || action == action_dash || action == action_slide) && _input_pressed("spin", player))
    {
        var _drop = false;
        
        if (_dropping)
        {
            if (ds_list_size(list_carry) > 0)
                _drop = true;
        }
        else
        {
            timer_func[timer_reset_action]();
            ds_list_clear(list_spinwait);
            var _action = action;
            
            if (_action == action_crouch || _action == action_slide)
                action = action_crouch_spin;
            else
                action = action_spin;
            
            event_squish(squish_land);
            audio_play_sound(snd_spin, 0, 0);
            override_sprite = noone;
            coyote_spin = 6;
            timer[timer_reset_action] = spin_time;
        }
        
        if (ds_list_size(list_carry) > 0)
        {
            if (!_drop)
                audio_play_sound(snd_throw, 0, 0);
            
            var _landObj = false;
            var _inst;
            
            if (place_meeting(x, y + 1, obj_movingsemi))
            {
                _inst = instance_place(x, y + 1, obj_movingsemi);
                _landObj = true;
            }
            
            for (var i = 0; i < ds_list_size(list_carry); i++)
            {
                with (ds_list_find_value(list_carry, i))
                {
                    ignore = other.id;
                    ignore_timer = 25;
                    
                    if (_drop)
                    {
                        dropped = true;
                        
                        if (_landObj)
                            landYobj = _inst;
                        else
                            landY = other.y - 4;
                        
                        if (place_meeting(x, y, obj_solid))
                        {
                            var _w = bbox_right - bbox_left;
                            var _mid = bbox_right - (_w / 2);
                            var _left = false;
                            var _right = false;
                            
                            for (var _xpos = _mid; _xpos <= bbox_right; _xpos++)
                            {
                                if (!place_meeting(_xpos + (_w / 2), y, obj_solid))
                                {
                                    x = _xpos + (_w / 2);
                                    _right = true;
                                    break;
                                }
                            }
                            
                            if (!_right)
                            {
                                for (var _xpos = _mid; _xpos >= bbox_left; _xpos--)
                                {
                                    if (!place_meeting(_xpos - (_w / 2), y, obj_solid))
                                    {
                                        x = _xpos - (_w / 2);
                                        _left = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        landY = room_height + 999;
                        tossed = true;
                        get_cams(0);
                        tossed_cam_xdiff = x - camx;
                    }
                    
                    event_user(0);
                }
            }
            
            ds_list_clear(list_carry);
        }
    }
    
    if (action != action_spin && action != action_crouch_spin)
        coyote_spin--;
}
