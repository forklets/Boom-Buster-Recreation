var _str = $"ghosts/tutorial/{room_get_name(room)}.json";

if (file_exists(_str))
    ghost_data = load_json(_str);
else
    instance_destroy();

frame = 0;

event_switch = function()
{
    out = true;
};

out = false;
