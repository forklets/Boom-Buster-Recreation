event_inherited();

if (input_check_pressed_all("spin") || input_check_pressed_all("back"))
{
    input_verb_consume_all("spin");
    input_verb_consume_all("back");
    
    with (obj_title_menu)
        deac = false;
    
    instance_destroy();
}
