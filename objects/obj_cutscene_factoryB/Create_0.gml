event_inherited();
cutscene = "FACTORY (B)";
my_room = rm_outskirts_b1;
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

cutscene_sprite = spr_cutscene_factoryB;

slide_check = function()
{
};

text_y = 0;
go = false;
texts[0] = "<cBRIDGET:<w They got hamsters up in this!/<oBUSTER:<w He's really pullin' out all the stops for this one.";
