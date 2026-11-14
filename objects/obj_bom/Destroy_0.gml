if (carried != noone)
{
    with (carried)
        ds_list_delete(list_carry, ds_list_find_index(list_carry, other.id));
}
