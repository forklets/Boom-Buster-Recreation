function room_goto_fade(arg0, arg1 = 60)
{
    var _trans = instance_create_layer(0, 0, "Transition", obj_transition_fade);
    _trans.myRoom = arg0;
    _trans.delay = arg1;
    return _trans;
}
