if (instance_exists(obj_paused))
    exit;

if (!array_contains(global.stages_final, room))
    exit;

if (obj_controller.cam_final)
    exit;

if (rise)
    rise_y -= ((1.7 - obj_controller.cam_spd) * 0.5);
else
    rise_y = approach(rise_y, 0, obj_controller.cam_spd * 0.5);

get_cams(0);
y = ((camy + 1080) - 128) + rise_y;

with (obj_controller)
{
    if (ps_lava != -4)
        part_system_position(ps_lava, room_width / 2, other.y);
}
