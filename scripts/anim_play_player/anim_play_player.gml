function anim_play_player(arg0, arg1)
{
    var _should;
    
    if (ds_list_size(list_carry) == 0)
        _should = arg0;
    else
        _should = arg1;
    
    var _replay;
    
    if (anim_sprite != _should && (anim_sprite == arg1 || anim_sprite == arg0))
        _replay = false;
    else
        _replay = true;
    
    if (!_replay)
        anim_sprite = _should;
    else
        anim_play(_should);
}
