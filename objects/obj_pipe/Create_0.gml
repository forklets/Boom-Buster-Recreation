pipe_yoff = 0;
wings_yoff = 0;
pipe_yoff_percent = 1;
surf = noone;
col = image_index;
image_index = 0;
anim_init();
set_sprite = false;

event_animend = function()
{
    if (anim_sprite == spr_pipe_enter)
    {
        if (fire && array_length(boms) > 0)
        {
            event_user(1);
        }
        else
        {
            if ((col % 2) == 0)
                anim_sprite = spr_pipe;
            else
                anim_sprite = spr_pipe_alt;
            
            anim_speed = 1;
        }
    }
};

shots = 0;
alarm[0] = 1;
combo_timer = 0;
combo = 0;
lastCombo = -4;
lastComboSnd = -4;
myScoreFX = noone;
comboScore = 0;
bonus_score = 0;
boms = [];
boms_index = 0;
fire = false;
myBox = noone;
