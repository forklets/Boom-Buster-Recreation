var _dir;

if (x < (room_width / 2))
    _dir = 1;
else
    _dir = -1;

var _onoff = instance_place(x + (4 * _dir), y, obj_onoff_orange);

if (_onoff)
{
    if (_onoff.anim_index == 0)
        exit;
}

hp -= 1;
shake = 1;

if (hp <= 0)
    instance_destroy();

var _w = bbox_right - bbox_left;
var _h = bbox_bottom - bbox_top;
var _life = 240;
var _subs;

if (hp <= 0)
    _subs = irandom_range(24, 24);
else
    _subs = irandom_range(7, 10);

var _spr = spr_tower_wall_shards;
var _xcenter = (bbox_right - bbox_left) / 2;
var _ycenter = (bbox_bottom - bbox_top) / 2;

for (var i = 0; i < _subs; i++)
{
    var _ptype1 = part_type_create();
    var _spd = irandom_range(7, 12);
    var _x = x + _xcenter + irandom_range(-_w / 2, _w / 2);
    var _y = (y + _ycenter) - irandom_range(-_h / 2, _h / 2);
    _dir = irandom_range(50, 130);
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
