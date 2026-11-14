function scr_get_achievement(arg0)
{
    if (extension_exists("Steamworks"))
        steam_set_achievement(arg0);
    
    variable_struct_get(global.achievements, arg0).got = true;
    ini_open("achievements.ini");
    ini_write_real("ACHIEVEMENTS", arg0, true);
    ini_close();
    
    if (arg0 != "BOOM_BUSTER")
    {
        ini_open("achievements.ini");
        global.all_got = true;
        struct_foreach(global.achievements, function(arg0, arg1)
        {
            if (!struct_exists(variable_struct_get(global.achievements, arg0), "secret"))
                variable_struct_get(global.achievements, arg0).secret = false;
            
            variable_struct_get(global.achievements, arg0).got = ini_read_real("ACHIEVEMENTS", arg0, false);
            
            if (arg0 != "BOOM_BUSTER")
            {
                if (!variable_struct_get(global.achievements, arg0).got)
                    global.all_got = false;
            }
        });
        
        if (global.all_got)
            scr_get_achievement("BOOM_BUSTER");
        
        ini_close();
    }
}
