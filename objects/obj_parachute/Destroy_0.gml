var _inst = instance_create_layer(x, y, layer, obj_parachute_away);

if (item == obj_bom)
{
    _inst.col = col;
    _inst.anim_sprite = spr_chute_colored;
}

_inst.anim_index = anim_index;
_inst.wave_offset = random_range(0, 1.5707963267948966);
