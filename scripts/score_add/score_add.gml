function score_add(arg0)
{
    if (room == rm_tutorial_7)
    {
        global.combo_meter += arg0;
        exit;
    }
    
    if (array_contains(global.stages_tutorial, room))
        exit;
    
    global.dollars += arg0;
    global.combo_meter += arg0;
}
