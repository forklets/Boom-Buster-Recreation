event_inherited();

if (instance_exists(hurt_box))
{
    if (anim_index >= 2 && !out)
        hurt_box.mask_index = spr_fx_explosion_hurt;
    else
        hurt_box.mask_index = noone;
}
