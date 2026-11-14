if (!instance_exists(obj_player))
{
    alarm[0] = 1;
    exit;
}

if (respawn_x == undefined)
{
    respawn_x = obj_player.x;
    respawn_y = obj_player.y;
}
