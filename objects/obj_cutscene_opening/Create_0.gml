cutscene = "OPENING";

if (!global.bside && !global.save.campaign_beat_A)
    my_room = rm_tutorial_1;
else
    my_room = rm_tutorial_ask;

if (global.bside)
    my_room = rm_round_b1;

texture_prefetch("tg_cutscene_opening");
event_inherited();
bgm_play = audio_play_sound(bgm_opening, 0, true);

event_on_press = function()
{
    if (slide == 8)
    {
        audio_play_sound(snd_lightning, 0, false);
        cutscene_index = -4;
        deac = true;
        audio_sound_gain(bgm_play, 0, 2000);
        timer[1] = 306;
        timer[2] = 210;
        go = false;
        text_y = text_y_start - text_sep;
        slide = 9;
    }
    else if (slide == 18)
    {
        event_room_end(120);
        deac = true;
        audio_sound_gain(bgm_play, 0, 1500);
    }
};

slide_check = function()
{
    if (slide == 1)
    {
        cutscene_index = 1;
    }
    else if (slide == 3)
    {
        cutscene_index = 2;
    }
    else if (slide == 5)
    {
        cutscene_index = 3;
    }
    else if (slide == 7)
    {
        cutscene_index = 4;
    }
    else if (slide == 10)
    {
        text_y_start = text_y;
        text_y = text_y_start - text_sep;
        deac = true;
        timer[1] = 180;
        cutscene_index = 5;
    }
    else if (slide == 11)
    {
        text_y_start = text_y;
        text_y = text_y_start - text_sep;
        cutscene_index = 6;
    }
    else if (slide == 14)
    {
        cutscene_index = 7;
    }
    else if (slide == 16)
    {
        cutscene_index = 8;
    }
    else if (slide == 18)
    {
        cutscene_index = 9;
    }
};

text_y = 0;
go = false;
texts[0] = "Far away in the outskirts of New York City lived an old magical being./A being ruled by hate, pain and evil.";
texts[1] = "Once an all powerful tyrant, now retired and lonely...";
texts[2] = "Suddenly, the old man gets a wild hair up his ass. He was made for/so much more than online games and energy drinks.";
texts[3] = "<lWIZARD<w: What am I doing? I used to rule this stupid, baby world./Where did I go wrong in this?";
texts[4] = "He needed to do something... Something that would restore his/rightful place as world leader.";
texts[5] = "<lWIZARD<w: That's it! I'll build a GIANT, EVIL WIZARD TOWER./That way, I can just look down on them, FOREVER. HA!! ";
texts[6] = "<lWIZARD<w: Maybe I'll even build MULTIPLE towers./And I'll throw in some moving platforms and coins, too!";
texts[7] = "<lWIZARD<w: Or my name isn't... THE WIZARD. GNAAAH HAH HAH HAAAH!/I AM THE WIZARD!!";
texts[8] = "Who could ever be so brave as to take down the Wizard, and stop his/horrifying reign of terror and doom?";
texts[9] = "";
texts[10] = "";
texts[11] = "<oBUSTER:<w At least we have each other!";
texts[12] = "<cBRIDGET:<w I can't move back in with my parents.";
texts[13] = "(Ring, ring!)";
texts[14] = "<oBUSTER:<w Boom! Buster Wrecking Company? How can we wreck ya?";
texts[15] = "<oBUSTER:<w Wait... Miss Mayor? A JOB? Are you tuggin' me!?/We'll be there in 60 frames!";
texts[16] = "<oBUSTER:<w BABE! Don't call 'ya parents just yet! We got a freakin' JOB!/<cBRIDGET:<w Wait, really?";
texts[17] = "<oBUSTER:<w Something about a big tower in the city?/Sounds wacky, but a job's a job!";
texts[18] = "And the silly video games were off, to end the Wizard's reign, and/if we're lucky, his life as well. Good luck, Buster and Bridget!";
timer[2] = -1;

timer_func[2] = function()
{
    if (audio_is_playing(bgm_play))
        audio_stop_sound(bgm_play);
    
    bgm_play = audio_play_sound(bgm_paused, 0, true);
    audio_sound_gain(bgm_play, 0, 0);
    audio_sound_gain(bgm_play, 1, 2000);
};
