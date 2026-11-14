event_inherited();

with (obj_bom_cage)
{
    if (col == other.col && instance_exists(bom_inside))
        event_user(1);
}
