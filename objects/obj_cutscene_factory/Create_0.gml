event_inherited();
cutscene = "FACTORY";
my_room = rm_outskirts_1;
texture_prefetch("tg_cutscene_factory");
bgm_play = audio_play_sound(bgm_cutscene_spooky, 0, true);

event_on_press = function()
{
    if (slide == 8)
    {
        event_room_end(210);
        deac = true;
        
        if (audio_is_playing(bgm_play))
            audio_stop_sound(bgm_play);
        
        audio_play_sound(snd_lightning, 0, false);
        draw_cutscene = false;
    }
};

cutscene_sprite = spr_cutscene_factory;

slide_check = function()
{
    if (slide == 1)
        cutscene_index = 1;
    else if (slide == 5)
        cutscene_index = 2;
};

text_y = 0;
go = false;
texts[0] = "<oBUSTER:<w Heh. Barely a scratch.";
texts[1] = "<oBUSTER:<w Whaddya say, Gramps? Ready to throw the towel in?";
texts[2] = "<lWIZARD:<w What are you, stupid? This rotten world needs a fresh start./My ideas are the key to a perfect society!";
texts[3] = "<oBUSTER:<w ...What? It ain't that serious./<cBRIDGET:<w Yeah, it's really not.";
texts[4] = "<lWIZARD:<w Not that serious? NOT THAT SERIOUS!!??/EVERYTHING is that serious. It will ALWAYS be that serious.";
texts[5] = "<lWIZARD:<w I tried being nice...";
texts[6] = "<lWIZARD:<w But it appears you've left me no choice...";
texts[7] = "<lWIZARD:<w My army...";
texts[8] = "                          <rBring out the super really hard levels.";
