if (exit_freeze())
    exit;

boms_index += (sprite_get_speed(bom_spr) / 60);

if (boms_index >= sprite_get_number(bom_spr))
    boms_index -= boms_index;

anim_logic();

if (combo_timer)
{
    combo_timer--;
}
else
{
    combo = 0;
    comboScore = 0;
}

pipe_yoff_percent = approach(pipe_yoff_percent, 1, 1/30);
pipe_yoff = use_curve(acurv_player, pipe_yoff_percent, "elastic", 44, 0);
