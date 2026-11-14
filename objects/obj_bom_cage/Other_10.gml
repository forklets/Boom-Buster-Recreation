cage_anim = instance_create_layer(x, y, layer, obj_bom_cage_anim);
cage_anim.my_cage = id;
cage_anim.col = col;

with (cage_anim)
{
    timer[0] = -1;
    bounces = 1;
    event_bounce();
}
