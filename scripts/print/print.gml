function print(arg0)
{
    if (!global.debug)
        exit;
    
    show_debug_message(arg0);
}
