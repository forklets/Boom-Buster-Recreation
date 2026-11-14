event_inherited();

if (input_check_pressed_all("spin") || input_check_pressed_all("back"))
{
    input_verb_consume_all("spin");
    input_verb_consume_all("back");
    instance_destroy();
}
