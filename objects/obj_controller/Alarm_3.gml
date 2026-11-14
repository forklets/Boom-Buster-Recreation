var _surf = surface_create(room_width, room_height);
var _tiles = ["Tiles_Behind", "Tiles_Behind_1", "Tiles_1", "Tiles_2", "Tiles_Decor", "Tiles_3", "Tiles_4", "Tiles_5"];
var _assets = ["Assets_1", "Assets_2"];
surface_set_target(_surf);
shader_set(sha_flash);

for (var i = 0; i < array_length(_tiles); i++)
{
    if (!layer_exists(layer_get_id(_tiles[i])))
        continue;
    
    var _id = layer_tilemap_get_id(_tiles[i]);
    draw_tilemap(_id, 0, 0);
}

for (var i = 0; i < array_length(_assets); i++)
{
    if (!layer_exists(_assets[i]))
        continue;
    
    var _elements = layer_get_all_elements(_assets[i]);
    
    for (var a = 0; a < array_length(_elements); a++)
    {
        var _draw = _elements[a];
        var _spr = layer_sprite_get_sprite(_draw);
        var _ind = layer_sprite_get_index(_draw);
        var _x = layer_sprite_get_x(_draw);
        var _y = layer_sprite_get_y(_draw);
        var _xscale = layer_sprite_get_xscale(_draw);
        var _yscale = layer_sprite_get_yscale(_draw);
        var _rot = layer_sprite_get_angle(_draw);
        draw_sprite_ext(_spr, _ind, _x, _y, _xscale, _yscale, _rot, c_white, 1);
    }
}

shader_reset();
surface_reset_target();
var _w = surface_get_width(_surf);
var _h = surface_get_height(_surf);
blood_mask = sprite_create_from_surface(_surf, 0, 0, _w, _h, false, false, 0, 0);
surface_free(_surf);
instance_create_depth(0, 0, layer_get_depth(layer_get_id("Instances")) + 20, obj_blood_draw);

if (room != global.last_room)
{
    global.blood = [];
    
    if (room != rm_round_7_2 && room != rm_round_7_3 && room != rm_round_b7_2 && room != rm_round_b7_3 && room != rm_round_14_2 && room != rm_round_b14_2 && room != rm_round_21_2 && room != rm_round_b21_2)
        global.deaths = 0;
}
else
{
    for (var i = 0; i < array_length(global.blood); i++)
    {
        var _inst = global.blood[i];
        var _splat = instance_create_layer(_inst.x, _inst.y, layer, obj_blood_splatter);
        _splat.sprite_index = _inst.sprite_index;
        _splat.image_index = _inst.image_index;
        _splat.x = _inst.x;
        _splat.y = _inst.y;
        _splat.image_xscale = _inst.image_xscale;
        _splat.image_yscale = _inst.image_yscale;
        _splat.image_angle = _inst.image_angle;
        _splat.image_alpha = _inst.image_alpha;
        _splat.visible = false;
    }
}
