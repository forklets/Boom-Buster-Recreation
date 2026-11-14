event_inherited();

if (inPipe || instance_exists(obj_player_death))
    exit;

var _idle = bom_idle;
var _edge = bom_edge;
var _omg = bom_omg;

if (timer[0] <= omg_time && !in_tutorial)
{
    if (!omg)
    {
        omg = true;
        hey_scale = 1.5;
    }
    
    if (anim_sprite != _omg)
    {
        yscale_squish = 1.3;
        xscale_squish = 0.7;
    }
    
    anim_play(_omg);
}
else if (timer[0] <= edge_time && !in_tutorial)
{
    if (!edge)
    {
        edge = true;
        hey_scale = 1.5;
    }
    
    if (anim_sprite != _edge)
    {
        yscale_squish = 1.3;
        xscale_squish = 0.7;
    }
    
    anim_play(_edge);
}
else
{
    anim_play(_idle);
}
