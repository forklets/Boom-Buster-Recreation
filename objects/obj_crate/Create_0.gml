test = false;
y += sprite_get_height(mask_index);
ystart = y;
anim_init();
flicker = false;
wings = false;
wing_ind = 0;
time = 0;

if (object_index == obj_crate_128 || object_index == obj_bricks_128)
    wing_width = 80;
else
    wing_width = 61;

wings_sin = 0;
jumpable = true;
grav = 0.3;
vspd = 0;
alarm[0] = 1;
angle = 0;

event_smoke = function()
{
    var _w = bbox_right - bbox_left;
    var _h = bbox_bottom - bbox_top;
    var _fx = instance_create_layer(x + (_w / 2), y - (_h / 2), "Particles_Over", obj_fx);
    var _scale;
    
    if (object_index == obj_crate_64)
        _scale = 1.1;
    else
        _scale = 2;
    
    with (_fx)
    {
        anim_play(spr_fx_smoke);
        image_xscale = _scale;
        image_yscale = _scale;
    }
};

event_ready = function()
{
    if (ready)
        return true;
    
    var _w = bbox_right - bbox_left;
    var _h = bbox_bottom - bbox_top;
    image_xscale = 1.25;
    image_yscale = 1.25;
    x = xstart - (_w * ((image_xscale - 1) / 2));
    y = ystart + (_h * ((image_yscale - 1) / 2));
    
    if (place_meeting(x, y, obj_player) || place_meeting(x, y, par_enemy))
    {
        image_xscale = 0;
        image_yscale = 0;
        return false;
    }
    
    x = xstart;
    y = ystart;
    image_xscale = 1;
    image_yscale = 1;
    ready = true;
    
    if (!global.playground && !array_contains(global.stages_final, room))
        event_smoke();
    
    return true;
};

ready = false;
physics_init();

if (object_index != obj_itemcrate)
    event_ready();

hp = 1;
item = obj_coin;

event_break = function()
{
    hp--;
    anim_index++;
    
    if (hp != 0)
        exit;
    
    if (object_index == obj_bricks || object_index == obj_bricks_128)
    {
    }
    
    var _w = bbox_right - bbox_left;
    var _h = bbox_bottom - bbox_top;
    var _spr;
    
    if (object_index == obj_metal_128)
        _spr = spr_metal_shards;
    else if (object_index == obj_bricks || object_index == obj_bricks_96 || object_index == obj_bricks_128)
        _spr = spr_brick_shards;
    else
        _spr = spr_crate_shards;
    
    var _life = 240;
    var _subs = irandom_range(7, 9);
    
    for (var i = 0; i < _subs; i++)
    {
        var _ptype1 = part_type_create();
        var _spd = irandom_range(7, 12);
        var _x = x + (_w / 2) + irandom_range(-40, 40);
        var _y = (y - (_h / 2)) + irandom_range(-40, 40);
        var _dir = irandom_range(50, 130);
        part_type_orientation(_ptype1, -20, 20, choose(1, 2, -1, -2) * 2, 0, false);
        part_type_sprite(_ptype1, _spr, false, false, false);
        part_type_speed(_ptype1, _spd, _spd, 0, 0);
        part_type_direction(_ptype1, _dir, _dir, 0, 0);
        part_type_gravity(_ptype1, 0.7, 270);
        part_type_life(_ptype1, _life, _life);
        part_type_subimage(_ptype1, i);
        part_particles_create(global.part_over, _x, _y, _ptype1, 1);
        ds_map_add(global.map_particles, _ptype1, _life);
    }
    
    var _inst;
    
    if (item != noone)
        _inst = instance_create_layer(x, y - (_h / 2), "Instances_Over", item);
    
    if (item == obj_coin)
    {
        _w = bbox_right - bbox_left;
        _h = bbox_bottom - bbox_top;
        
        with (_inst)
        {
            x = other.x + (_w / 2);
            y = other.y - (_h / 2);
            event_user(0);
        }
    }
    
    if (wings)
    {
        _w = bbox_right - bbox_left;
        _h = bbox_bottom - bbox_top;
        var _x = x + (_w / 2);
        var _y = y - (_h / 2) - 12;
        _inst = instance_create_depth(_x, _y, layer_get_depth(layer) + 1, obj_wings_away);
        _inst.anim_index = wing_ind;
        _inst.wing_width = wing_width;
        _inst.wings_yoffset = 0;
    }
    
    var _strength;
    
    if (object_index == obj_crate_128 || object_index == obj_bricks_128 || object_index == obj_metal_128)
        _strength = 1;
    else if (object_index == obj_crate || object_index == obj_bricks_96)
        _strength = 0.5;
    else
        _strength = 0.3;
    
    screen_shake(10 * _strength, 10 * _strength);
    var _snd = audio_play_sound(break_sound, 0, 0);
    audio_sound_gain(_snd, _strength, 0);
    instance_destroy();
};

timer[0] = 240;

timer_func[0] = function()
{
    event_smoke();
    instance_destroy();
};

timer[1] = -1;

timer_func[1] = function()
{
    flicker = !flicker;
};

event_floor = function()
{
    vspd = 0;
};

break_sound = snd_break_wood;
