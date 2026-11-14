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

global.elements = [];
