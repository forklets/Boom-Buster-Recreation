set_speed();

if (image_xscale == -1)
{
    image_xscale = 1;
    x -= 64;
}

for (var i = 0; i < fireballs; i++)
{
    var _inst = instance_create_depth(x, y, depth - 1, obj_firebar_fireball);
    _inst.block = id;
    _inst.num = i;
}
