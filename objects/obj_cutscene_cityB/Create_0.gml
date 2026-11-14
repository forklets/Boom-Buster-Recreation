event_inherited();
cutscene = "CITY (B)";
my_room = rm_round_b8;
texture_prefetch("tg_cutscene_city");
cutscene_sprite = spr_cutscene_cityB;
bgm_play = audio_play_sound(bgm_cutscene, 0, true);

event_on_press = function()
{
    if (slide == 0)
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
texts[0] = "<oBUSTER:<w Peepaw over here. Guy's got bingo at 4.";
