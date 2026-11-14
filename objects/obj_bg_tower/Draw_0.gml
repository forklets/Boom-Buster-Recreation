if (!ready)
    exit;

if (!ready || ymove_last == undefined)
    exit;

get_cams(0);
var _dist = ymove_last - camy;
var _w = sprite_get_width(sprite_index);
var _h = sprite_get_height(sprite_index);
var _x = 0;
var _y = -_h;
var _farness = 0.5;
ymove += _dist;

if (ymove > (_h * 2))
    ymove -= (_h * 2);

get_cams(0);

for (var i = 0; i < (camw / _w); i++)
{
    for (var j = 0; j < ((camh + _h) / _h); j++)
    {
        var _xx = camx + (i * _w);
        var _yy = _y + camy + (j * _h) + (ymove * _farness);
        draw_sprite(sprite_index, 0, _xx - 32, _yy);
    }
}
