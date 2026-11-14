if (go)
    exit;

draw_set_font(obj_persistent.font_pixel);
var _scale = 3;
var _x = 960;
var _y = 400;
scr_text_custom_draw(_x, _y, text_header, _scale, 60);
_y += 200;
shake = approach(shake, 0, 0.25);

for (var i = 0; i < 2; i++)
{
    var xshake, yshake;
    
    if (selected != i)
    {
        xshake = 0;
        yshake = 0;
    }
    else
    {
        xshake = irandom_range(-1, 1) * shake;
        yshake = irandom_range(-1, 1) * shake;
    }
    
    var _strs = [text_yes, text_no];
    var _str = _strs[i];
    
    if (selected == i)
    {
        draw_set_font(obj_persistent.font_pixel_gradient_prop);
        draw_set_color(c_yellow);
        pal_swap(pal_font_gradient, 0, 1);
    }
    else
    {
        draw_set_font(obj_persistent.font_pixel);
        draw_set_color(c_white);
    }
    
    scr_text_custom_draw(_x + xshake, _y + yshake, _str, _scale, 60);
    _y += 60;
    draw_set_color(c_white);
    
    if (selected == i)
        shader_reset();
}

draw_sprite_tiled_ext(spr_scanlines, 0, 0, 0, 1, 2, c_white, 0.25);
