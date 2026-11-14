if (input_check_pressed("back") || input_check_pressed("spin"))
{
    input_verb_consume("back");
    input_verb_consume("spin");
    
    with (obj_options)
        deac = false;
    
    with (obj_title_extras)
        deac = false;
    
    instance_destroy();
}
