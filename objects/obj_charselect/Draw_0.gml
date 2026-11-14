if (!display)
    exit;

var _x = 960;
var _y = 120;

for (var i = 0; i < sprite_get_number(spr_pickdat); i++)
{
    var _hue = (hue + 1 + (i * 20)) % 255;
    var _col = make_colour_hsv(_hue, 112, 255);
    var _yoff = sin((current_time / 120) + (i * pi * 0.15)) * 3;
    draw_sprite_ext(spr_pickdat, i, _x, _y + _yoff, 1, 1, 0, _col, 1);
}

var _sep = 345;
var _dir;

if (selected == 0)
    _dir = -1;
else
    _dir = 1;

if (!deac)
    draw_sprite(spr_pickdat_arrow, 0, _x + (_sep * _dir), _y + 120 + (sin(current_time / 120) * 4));

var _spr = [spr_charselect_buster, spr_charselect_bridget];

for (var i = 0; i < 2; i++)
{
    _x = 960;
    _y = 570;
    
    if (i == 0)
        _x -= _sep;
    else
        _x += _sep;
    
    var _ind;
    
    if (selected != i)
        _ind = 1;
    else
        _ind = 0;
    
    draw_sprite(_spr[i], _ind, _x, _y);
    
    if (selected != i)
        draw_sprite_ext(_spr[i], _ind, _x, _y, 1, 1, 0, c_black, 0.45);
}
