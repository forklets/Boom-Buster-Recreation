ini_open("options.ini");
ini_write_real("OPTIONS", "Fullscreen", window_get_fullscreen());
ini_close();
if (extension_exists("Steamworks"))
    steam_shutdown();
