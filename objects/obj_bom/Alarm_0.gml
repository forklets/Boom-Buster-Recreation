if (object_index != obj_bom && object_index != obj_bom_cyan)
    exit;

if (col == 0)
{
    bom_idle = spr_bom_orange;
    bom_edge = spr_bom_orange_edge;
    bom_omg = spr_bom_orange_omg;
}
else if (col == 1)
{
    bom_idle = spr_bom_cyan;
    bom_edge = spr_bom_cyan_edge;
    bom_omg = spr_bom_cyan_omg;
}
else if (col == 2)
{
    bom_idle = spr_bom_purple;
    bom_edge = spr_bom_purple_edge;
    bom_omg = spr_bom_purple_omg;
}
else if (col == 3)
{
    bom_idle = spr_bom_lime;
    bom_edge = spr_bom_lime_edge;
    bom_omg = spr_bom_lime_omg;
}
else if (col == 4)
{
    bom_idle = spr_bom_yellow;
    bom_edge = spr_bom_yellow_edge;
    bom_omg = spr_bom_yellow_omg;
}
