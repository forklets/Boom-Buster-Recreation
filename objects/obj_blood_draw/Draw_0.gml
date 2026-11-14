with (obj_controller)
{
    draw_set_mask(0, 0, blood_mask);
    
    with (obj_blood_splatter)
    {
        visible = true;
        draw_self();
        visible = false;
    }
    
    draw_reset_clip();
}
