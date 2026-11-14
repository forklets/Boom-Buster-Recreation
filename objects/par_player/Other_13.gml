var _list = ds_list_create();

if (global.powerup != 1)
    instance_place_list(x, y, par_carry, _list, true);

if (ds_list_size(_list) > 0)
{
    var _og;
    
    if (ds_list_size(list_carry) > 0)
        _og = ds_list_find_value(list_carry, 0);
    else
        _og = noone;
    
    for (var i = 0; i < ds_list_size(_list); i++)
    {
        var _inst = ds_list_find_value(_list, i);
        
        if (_inst.caged)
            continue;
        
        var _same;
        
        if (_og != noone)
        {
            if (_inst.col == _og.col || _inst.col == 21)
                _same = true;
            else
                _same = false;
        }
        else
        {
            _same = true;
        }
        
        if (_inst.carried == noone && _inst.ignore != id && !_inst.tossed && !_inst.thrown && _inst.landed && _same)
        {
            with (_inst)
                event_grabbed(other.id);
            
            ds_list_add(list_carry, _inst);
            
            if (_og == noone)
                _og = ds_list_find_value(list_carry, 0);
            
            var _snd = audio_play_sound(snd_nab, 0, 0);
            audio_sound_pitch(_snd, 1 + (0.1 * ds_list_size(list_carry)));
        }
    }
}

ds_list_destroy(_list);
