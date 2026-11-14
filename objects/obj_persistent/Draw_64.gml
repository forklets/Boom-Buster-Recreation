if (global.texfilter)
    gpu_set_texfilter(true);

gpu_set_blendenable(false);
draw_surface(application_surface, 0, 0);
gpu_set_blendenable(true);

if (global.texfilter)
    gpu_set_texfilter(false);
