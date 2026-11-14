event_inherited();
stompable = false;

if (global.ball_clean)
{
    sprite_spun = spr_ball_spun_clean;
    sprite_move = spr_ball_clean;
    anim_play(spr_ball_clean);
}
else
{
    sprite_spun = spr_ball_spun;
    sprite_move = spr_ball;
    anim_play(spr_ball);
}

eyes_sprite = spr_ball_eyes;
possible_eyes = [spr_ball, spr_ball_clean, spr_ball_impaled, spr_ball_impaled_bridget];
mask_hurt = spr_ball_hurt;
ledge_turn = true;
