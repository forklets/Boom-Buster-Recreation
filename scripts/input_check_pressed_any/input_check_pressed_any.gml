function input_check_pressed_all_any()
{
    if (input_check_pressed_all("jump") || input_check_pressed_all("spin") || input_check_pressed_all("dash") || input_check_pressed_all("start") || input_check_pressed_all("special"))
        return true;
}
