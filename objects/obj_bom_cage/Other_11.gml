with (bom_inside)
{
    caged = false;
    vspd = -10;
}

bom_inside = noone;
col = -1;

with (cage_anim)
    instance_destroy();

anim_play(spr_bom_cage_open);
