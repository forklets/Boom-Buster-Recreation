ypos[0] = (room_height + 32) - 64;
ypos[1] = room_height + 32;
var _w = sprite_get_width(spr_fog);
var _spd = [-0.35, -1];

for (var i = 0; i < 2; i++)
{
    xmove[i] += _spd[i];
    
    if (xmove[i] <= (-_w * 2))
        xmove[i] += _w * 2;
}
