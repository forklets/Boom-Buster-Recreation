event_inherited();
anim_play(spr_orb);
worth = 0.05;
time_angle = 0;
bom_timer_add = 15;

event_collect = function(arg0)
{
    global.combo_meter += 0.2;
    var _size = 0;

    with (arg0)
    {
        _size = ds_list_size(list_carry);

        for (var i = 0; i < _size; i++)
        {
            if (ds_list_find_value(list_carry, i).object_index == obj_key)
                continue;

            if (ds_list_find_value(list_carry, i).object_index == obj_gem)
                ds_list_find_value(list_carry, i).life = ds_list_find_value(list_carry, i).life + other.bom_timer_add;
            else
                array_set(ds_list_find_value(list_carry, i).timer, 0, ds_list_find_value(list_carry, i).timer[0] + other.bom_timer_add);

            ds_list_find_value(list_carry, i).flash_nuclear_alpha = 1;
        }
    }

    var _fx = instance_create_layer(x, y, "Instances", obj_orb_got);

    if (_size > 0)
    {
        var _ps = global.part_over;
        var _ptype1 = part_type_create();
        part_type_shape(_ptype1, 1);
        part_type_size(_ptype1, 0.8, 1.1, -0.012, 0);
        part_type_scale(_ptype1, 0.175, 0.175);
        part_type_speed(_ptype1, 5, 8, 0, 0);
        part_type_direction(_ptype1, 70, 110, 0, 0);
        part_type_gravity(_ptype1, 0.4, 270);
        part_type_orientation(_ptype1, 0, 20, 0, 0, false);
        part_type_colour3(_ptype1, 1703743, 58150, 58150);
        part_type_alpha3(_ptype1, 1, 1, 0.18);
        part_type_blend(_ptype1, true);
        part_type_life(_ptype1, 16, 25);
        var _pemit1 = part_emitter_create(_ps);
        part_emitter_region(_ps, _pemit1, x + -24, x + 24, y + 24 + -24, y + 24 + 24, 0, 0);
        part_emitter_burst(_ps, _pemit1, _ptype1, irandom_range(16, 18));
        part_emitter_destroy(_ps, _pemit1);
        var _event = method(
        {
            pt: _ptype1
        }, function()
        {
            if (part_type_exists(pt))
                part_type_destroy(pt);
        });
        call_later(120, time_source_units_frames, _event);
    }
};

depth += 10;
yoff = 0;
image_xscale = 1.1;
image_yscale = 1.1;
