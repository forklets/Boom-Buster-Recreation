event_inherited();

if (!ready)
    exit;

if (input_check_pressed_all(global.input_menu_special) && !global.playground && !global.round_select && !instance_exists(obj_options) && !instance_exists(obj_achievements) && !array_contains(global.stages_final, room))
{
    deac = true;
    event_multiplayer();
}

if (!delay && !instance_exists(obj_options) && !instance_exists(obj_achievements))
    event_user(0);

if (delay)
    delay--;

timer_logic(0);
var _remap = false;

if (instance_exists(obj_options) && obj_options.menu_selected == obj_options.menu_remap)
    _remap = true;

if (little_buster_go && !instance_exists(obj_multiplayer) && !instance_exists(obj_achievements) && !_remap && !instance_exists(obj_howtoplay))
{
    var _anims = [spr_arcade_buster, spr_arcade_buster_walk, spr_arcade_buster_jump, spr_arcade_buster_skid];
    buster_x = global.pause_buster_data[buster_frame].x;
    buster_y = global.pause_buster_data[buster_frame].y;
    var _anim = global.pause_buster_data[buster_frame].a;
    buster_facing = global.pause_buster_data[buster_frame].fac;
    buster_ind = global.pause_buster_data[buster_frame].ind;
    
    if (buster_spr != _anims[_anim])
    {
        buster_ind = 0;
        buster_spr = _anims[_anim];
    }
    
    if (buster_frame < (array_length(global.pause_buster_data) - 1))
        buster_frame++;
}
