if (instance_exists(carried))
{
    with (carried)
    {
        for (var i = 0; i < ds_list_size(list_carry); i++)
        {
            if (ds_list_find_value(list_carry, i) == other.id)
            {
                ds_list_delete(list_carry, i);
                break;
            }
        }
    }
}
