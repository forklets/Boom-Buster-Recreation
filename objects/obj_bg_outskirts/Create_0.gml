event_inherited();
bg_script = scr_bg_outskirts;

for (var i = 0; i < 3; i++)
    clouds_x[i] = 0;

with (obj_controller)
    tv_bg_ind = 3;

var _depth = layer_get_depth(layer_get_id("GUI")) + 20;
var _fog = instance_create_depth(0, room_height - 32, _depth, obj_fog);
