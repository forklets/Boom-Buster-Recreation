if (col == 2)
{
    pipe_idle = spr_pipe_purple;
    bom_spr = spr_bom_purple;
}
else if (col == 1)
{
    pipe_idle = spr_pipe_cyan;
    bom_spr = spr_bom_cyan;
}
else if (col == 3)
{
    pipe_idle = spr_pipe_cyan;
    bom_spr = spr_bom_lime;
}
else if (col == 4)
{
    pipe_idle = spr_pipe_orange;
    bom_spr = spr_bom_yellow;
}
else
{
    pipe_idle = spr_pipe_orange;
    bom_spr = spr_bom_orange;
}

if (!set_sprite)
{
    if ((col % 2) == 0)
        anim_sprite = spr_pipe;
    else
        anim_sprite = spr_pipe_alt;
    
    set_sprite = true;
}
