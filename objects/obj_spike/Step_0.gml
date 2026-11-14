if (exit_freeze())
    exit;

var _player = instance_place(x, y - 1, obj_player);

if (_player)
{
    with (_player)
    {
        hurt_by = other;
        event_user(0);
    }
}

anim_logic();
