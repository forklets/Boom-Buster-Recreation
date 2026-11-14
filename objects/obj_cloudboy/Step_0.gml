event_inherited();

if (exit_freeze())
    exit;

anim_logic();
face_ind += (sprite_get_speed(face_sprite) / 60);

if (face_ind >= sprite_get_number(face_sprite))
{
    face_ind -= face_ind;
    event_face_animend();
}

xscale = use_curve(acurv_player, scale_percent, "elastic", 1.25, 1);
yscale = use_curve(acurv_player, scale_percent, "elastic", 0.68, 1);
scale_percent = approach(scale_percent, 1, 0.006666666666666667);
