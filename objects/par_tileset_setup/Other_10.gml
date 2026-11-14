var _tileset_name = tileset;
var _checks = [obj_footstep_grass, obj_footstep_metal];
struct_set(global.tile_data, _tileset_name, {});

for (var c = 0; c < array_length(_checks); c++)
{
    for (var i = 0; i < (room_width / 64); i++)
    {
        for (var j = 0; j < (room_height / 64); j++)
        {
            var _column = ((i * 64) div 64) + ((room_width / 64) * j);
            var _x = i * 64;
            var _y = j * 64;
            
            if (collision_rectangle(_x, _y, _x + 64, _y + 64, _checks[c], true, true))
                struct_set(variable_struct_get(global.tile_data, _tileset_name), _column, c);
        }
    }
}

with (obj_tileset_setup_manager)
    event_user(0);
