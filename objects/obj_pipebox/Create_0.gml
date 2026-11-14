wings = false;
wing_ind = 0;
wings_sin = 0;
time = 0;
anim_init();
pipe_bg = instance_create_depth(x, y, layer_get_depth(layer) + 1, obj_pipe_bg);

with (pipe_bg)
    image_speed = 0;

depth--;
visible = false;
col = 0;
