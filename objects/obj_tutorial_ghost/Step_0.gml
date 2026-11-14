if (!instance_exists(obj_stagestart))
    frame++;

if (frame > (array_length(ghost_data) - 1))
    frame = 0;

var _data = ghost_data[frame];
x = _data.x;
y = _data.y;
anim_sprite = asset_get_index(_data.spr);
anim_index = _data.ind;
facing = _data.facing;
xscale_squish = _data.xscale_squish;
yscale_squish = _data.yscale_squish;

if (out)
    image_alpha = approach(image_alpha, 0, 0.1);
