var _ind_max = sprite_get_number(spr_blood_splatter) - 1;

for (var i = 0; i < irandom_range(4, 6); i++)
{
    var _spr = spr_blood_splatter;
    var _x, _y, _scale, _alpha;
    
    if (i == 0)
    {
        _x = x;
        _y = y - 38;
        _scale = 1.5;
        _alpha = random_range(0.6, 0.7);
    }
    else
    {
        _x = x + irandom_range(-72, 72);
        _y = (y + irandom_range(-72, 72)) - 38;
        _scale = random_range(0.8, 1.15);
        _alpha = random_range(0.2, 0.4);
    }
    
    var _rot = irandom_range(0, 359);
    var _index = irandom_range(0, _ind_max);
    var _inst = instance_create_layer(_x, _y, layer, obj_blood_splatter);
    _inst.image_xscale = _scale;
    _inst.image_yscale = _scale;
    _inst.image_angle = _rot;
    _inst.image_index = _index;
    _inst.image_alpha = _alpha;
    var _data = 
    {
        sprite_index: _spr,
        image_index: _index,
        x: _x,
        y: _y,
        image_xscale: _scale,
        image_yscale: _scale,
        image_angle: _rot,
        image_alpha: _alpha
    };
    
    if (array_length(global.blood) < 100)
        array_push(global.blood, _data);
}

var _count_back = random_range(60, 80) + blood_burst_amount_offset;
var _count_mid = random_range(70, 90) + blood_burst_amount_offset;
var _count_front = random_range(50, 70) + blood_burst_amount_offset;
var _ps = part_system_create();
part_system_draw_order(_ps, true);
var _ptype1 = part_type_create();
part_type_shape(_ptype1, 2);
part_type_size(_ptype1, 0.8, 1.35, -0.012, 0);
part_type_scale(_ptype1, 0.175, 0.175);
part_type_speed(_ptype1, 11, 20, 0, 0);
part_type_direction(_ptype1, 70, 110, 0, 0);
part_type_gravity(_ptype1, 0.6, 270);
part_type_orientation(_ptype1, 0, 0, 0, 0, false);
part_type_colour3(_ptype1, 4474085, 2302898, 153);
part_type_alpha3(_ptype1, 1, 1, 0.18);
part_type_blend(_ptype1, false);
part_type_life(_ptype1, 62, 100);
var _pemit1 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit1, -36.15516, 32.15516, -26.258606, 56.258606, 0, 0);
part_emitter_burst(_ps, _pemit1, _ptype1, _count_back);
var _ptype2 = part_type_create();
part_type_shape(_ptype2, 2);
part_type_size(_ptype2, 0.8, 1.35, -0.012, 0);
part_type_scale(_ptype2, 0.2, 0.2);
part_type_speed(_ptype2, 11, 20, 0, 0);
part_type_direction(_ptype2, 80, 100, 0, 0);
part_type_gravity(_ptype2, 0.6, 270);
part_type_orientation(_ptype2, 0, 0, 0, 0, false);
part_type_colour3(_ptype2, 204, 178, 153);
part_type_alpha3(_ptype2, 1, 1, 0.18);
part_type_blend(_ptype2, false);
part_type_life(_ptype2, 62, 100);
var _pemit2 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit2, -36.15516, 32.15516, -26.258606, 56.258606, 0, 0);
part_emitter_burst(_ps, _pemit2, _ptype2, _count_mid);
var _ptype3 = part_type_create();
part_type_shape(_ptype3, 2);
part_type_size(_ptype3, 0.8, 1.35, -0.012, 0);
part_type_scale(_ptype3, 0.15, 0.15);
part_type_speed(_ptype3, 11, 20, 0, 0);
part_type_direction(_ptype3, 70, 110, 0, 0);
part_type_gravity(_ptype3, 0.6, 270);
part_type_orientation(_ptype3, 0, 0, 0, 0, false);
part_type_colour3(_ptype3, 127, 107, 153);
part_type_alpha3(_ptype3, 1, 1, 0.18);
part_type_blend(_ptype3, false);
part_type_life(_ptype3, 62, 100);
var _pemit3 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit3, -36.15516, 32.15516, -26.258606, 56.258606, 0, 0);
part_emitter_burst(_ps, _pemit3, _ptype3, _count_front);
part_system_position(_ps, x, y + 16);
