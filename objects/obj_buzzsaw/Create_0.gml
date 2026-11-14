bonus_freeze = false;
angle = image_angle;
anim_init();
path_init(false);
hspd = 0;
vspd = 0;
on_path = true;
rotate = true;
anim_speed = 0;

for (var i = 0; i < array_length(global.hurt_remember); i++)
{
    var _inst = global.hurt_remember[i];
    
    if (_inst.x == xstart && _inst.y == ystart && _inst.object_index == _inst.object_index)
        anim_index++;
}

if (anim_index > (sprite_get_number(anim_sprite) - 1))
    anim_index = sprite_get_number(anim_sprite) - 1;

if (anim_index == (sprite_get_number(anim_sprite) - 1))
    scr_get_achievement("BUZZSAW");
