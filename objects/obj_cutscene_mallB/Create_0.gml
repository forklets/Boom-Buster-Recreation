event_inherited();
cutscene = "MALL (B)";
my_room = rm_round_b15;
cutscene_sprite = spr_cutscene_mallB;
texture_prefetch("tg_cutscene_mall");
bgm_play = audio_play_sound(bgm_cutscene, 0, true);

event_on_press = function()
{
    if (slide == (array_length(texts) - 1))
    {
        event_room_end(120);
        deac = true;
        audio_sound_gain(bgm_play, 0, 1500);
    }
};

slide_check = function()
{
};

text_y = 0;
go = false;
texts[0] = "<oBUSTER:<w I want a monster truck, a meatball sub, a hundred dollars,/two Bridgets, a new dad, ice cream, a flat screen TV, and uh...";
