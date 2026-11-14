event_inherited();

if (instance_exists(obj_bom))
    instance_destroy();

timer_logic(0);
get_cams(0);

if (y >= camy && ready)
    prompt = true;
