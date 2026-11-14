if (!ready || exit_freeze())
    exit;

y += vspd;

if (bbox_bottom >= (obj_pipe.y - 8))
    event_explode();

anim_logic();
var _player = instance_place(x, y, par_player);

if (_player)
    event_touch(_player);
