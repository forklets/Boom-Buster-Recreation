fire = true;

if (instance_exists(obj_tower))
{
    var _diff = 5.1;
    var _percent = shots / obj_controller.boms_total;
    anim_speed = 1.7 + (_diff * _percent);
}
else
{
    anim_speed = 1.7;
}

audio_stop_play(snd_cannon_shoot, 0, 0);
anim_play(spr_pipe_enter);
array_pop(boms);
shots++;
var _bom = instance_create_layer(x + 128, y + 50, "Instances", obj_bom_shoot);
_bom.anim_sprite = bom_spr;
