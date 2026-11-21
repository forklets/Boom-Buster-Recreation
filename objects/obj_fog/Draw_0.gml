get_cams(0);
var _alpha = [0.3, 0.5];
var _dist = [0, -0.1];
var _bm = 0;
gpu_set_blendmode(_bm);

for (var j = 0; j < 2; j++)
{
    var _w = sprite_get_width(spr_fog);
    var _x = (camx * _dist[j]) + xmove[j];
    var _col = 16777215;

    for (var i = 0; i < 30; i++)
    {
        var _xx = _x + (_w * i);

        if (_xx < (camx - 1920) || _xx > (camx + 1920))
            continue;

        draw_sprite_ext(spr_fog_1, i, _xx, ypos[j] + yoff, 1, image_yscale, 0, _col, _alpha[j] * image_alpha);
    }
}

gpu_set_blendmode(bm_normal);
