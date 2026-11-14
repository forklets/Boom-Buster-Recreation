event_inherited();
cutscene = "CITY";
my_room = rm_round_8;
texture_prefetch("tg_cutscene_city");
cutscene_sprite = spr_cutscene_city;
bgm_play = audio_play_sound(bgm_cutscene, 0, true);

event_on_press = function()
{
    if (slide == 10)
    {
        event_room_end(120);
        deac = true;
        audio_sound_gain(bgm_play, 0, 1500);
    }
};

slide_check = function()
{
    if (slide == 8)
        cutscene_index++;
};

text_y = 0;
go = false;
texts[0] = "<oBUSTER:<w How's it hangin' brotha man?";
texts[1] = "<lWIZARD:<w Brother man? What the hell?/Do you realize who you're talking to?";
texts[2] = "<oBUSTER:<w Hey, you might wanna make way. Demolition zone.";
texts[3] = "<lWIZARD:<w Is my brain f*cking fried? Demolishing MY towers?/Were you born yesterday?";
texts[4] = "<lWIZARD:<w I am the Almighty Wizard. Soon to be ruler of New York./Didn't you learn about me in school?";
texts[5] = "<cBRIDGET:<w The Almighty... Wizard?/<oBUSTER:<w A Wizard? That's hilarious.";
texts[6] = "<lWIZARD:<w Listen, you little punk. Quit while you're ahead./Becoming my enemy will lead to a road of PAIN and MISERY.";
texts[7] = "<lWIZARD:<w Now SCRAM!";
texts[8] = "<cBRIDGET:<w Oh, Buster... I got a bad feeling about this guy./Is he gonna be trouble?";
texts[9] = "<oBUSTER:<w I dunno.";
texts[10] = "That was awkward. But a job's a job!/The two make their way to the next tower...";
