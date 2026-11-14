if (!set)
    exit;

draw_set_font(drawfont);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
var _scale = 0.75;
var _sep = 50 * _scale;
w = array_length(text) * _sep;

for (var i = 0; i < array_length(text); i++)
{
    if (ready[i])
    {
        if (!exit_freeze())
        {
            shakeXoff = (irandom_range(0, 1) - (w / 2)) + 5;
            shakeYoff = irandom_range(0, 1) + 10;
            scalew = choose(1, 1.02) * scale[i];
            scaleh = choose(1, 1.02) * scale[i];
        }
        
        draw_set_alpha(image_alpha);
        draw_text_transformed(x + shakeXoff + (_sep * i), y + shakeYoff + yoff[i], text[i], scalew * _scale, scaleh * _scale, 0);
        draw_set_alpha(alpha[i] * alphaTotal[i]);
        shader_set(sha_flash);
        
        if (drawfont == obj_persistent.font_coins)
            draw_set_color(c_yellow);
        else
            draw_set_color(c_lime);
        
        draw_text_transformed(x + shakeXoff + (_sep * i), y + shakeYoff + yoff[i], text[i], scalew * (scale[i] * 1) * _scale, scaleh * scale[i] * _scale, 0);
        shader_reset();
        draw_set_color(c_white);
        draw_set_alpha(1);
    }
}

draw_set_valign(fa_top);
draw_set_halign(fa_left);
