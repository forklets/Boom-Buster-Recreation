collected = false;
worth = 0.01;
coin_round = image_index;
anim_init();
anim_play(spr_coin_map);

if (global.orb_round != image_index)
    image_alpha = 0;

event_collect = function(arg0)
{
};
