event_inherited();

if (global.bside)
{
    instance_create_layer(x, y, layer, obj_bg_sunset);
    exit;
}

bg_script = scr_bg_city;
clouds_x = 0;
fog_x[0] = 0;
fog_x[1] = -720;
var _depth = layer_get_depth(layer_get_id("GUI")) + 20;
var _fog = instance_create_depth(0, room_height - 32, _depth, obj_fog);
