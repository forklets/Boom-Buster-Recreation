with (par_player)
{
    var _x = x - 30;
    var _y = y - 192;
    var _scale = 1;
    
    if (other.prompt_ind)
    {
        _scale = 0.9;
        _x += 4;
        _y += 4;
    }
    
    draw_set_alpha(other.prompt_alpha);
    draw_glyph("X", _x, _y, _scale, other.prompt_alpha);
    draw_set_alpha(1);
    
    if (other.prompt_ind)
    {
        shader_set(sha_flash);
        draw_set_alpha(other.prompt_alpha * 0.2);
        draw_glyph("X", _x, _y, _scale, other.prompt_alpha * 0.2);
        draw_set_alpha(1);
        shader_reset();
    }
}
