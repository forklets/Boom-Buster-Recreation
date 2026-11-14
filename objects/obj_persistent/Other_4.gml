app_resize = false;
application_surface_draw_enable(false);
display_set_gui_size(1920, 1080);
display_set_gui_size(1920, 1080);
surface_resize(application_surface, 1920, 1080);
exit;

if (room == rm_title || room == rm_results || room == rm_disclaimer || room == rm_cutscene_opening)
{
    app_resize = false;
    surface_resize(application_surface, 1920, 1080);
}
else
{
    app_resize = true;
    surface_resize(application_surface, 1408, 1080);
}
