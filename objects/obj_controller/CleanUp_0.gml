if (surface_exists(surf_gui))
    surface_free(surf_gui);

if (surface_exists(view_surf))
    surface_free(view_surf);

if (sprite_exists(blood_mask))
    sprite_delete(blood_mask);

if (part_system_exists(ps_rain))
    part_system_destroy(ps_rain);

if (part_system_exists(ps_lava))
    part_system_destroy(ps_lava);

if (part_type_exists(part_type_rain))
    part_type_destroy(part_type_rain);

if (part_type_exists(part_type_lava))
    part_type_destroy(part_type_lava);

global.elements = [];

with (par_physics)
{
    if (ds_exists(list_collision, ds_type_list))
        ds_list_destroy(list_collision);
}

with (par_physics)
{
    if (ds_exists(list_ignore, ds_type_list))
        ds_list_destroy(list_ignore);
}
