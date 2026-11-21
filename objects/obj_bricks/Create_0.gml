timer[0] = -1;

timer_func[0] = function()
{
    mask_index = spr_solid;
    image_alpha = 1;
    var _list = [];
    instance_place_array(x, y, par_physics);

    for (var i = 0; i < array_length(_list); i++)
    {
        with (_list[i])
            ds_list_add(list_ignore, other.id);
    }

    _list = [];
};
