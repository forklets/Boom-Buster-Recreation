event_inherited();
cutscene = "MALL";
my_room = rm_round_15;
cutscene_sprite = spr_cutscene_mall;
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
    if (slide == 4 || slide == 6)
        cutscene_index++;
};

text_y = 0;
go = false;
texts[0] = "<oBUSTER:<w Listen, buddy. The rotating fireballs were kinda cool/at first, but I gotta get these towers down for the mayor.";
texts[1] = "<lWIZARD:<w The mayor? You think that government employee scares me?/I'm a literal magical wizard. I create fire with my bare hands.";
texts[2] = "<cBRIDGET:<w We're sorry, mister Wizard, sir. But this is our job./And if we don't finish it, we'll lose our house.";
texts[3] = "<lWIZARD:<w Why the hell is that my problem? Just get a new one.";
texts[4] = "<oBUSTER:<w Wait a minute. I just realized something.";
texts[5] = "<oBUSTER:<w You're a stupid piece of shit!";
texts[6] = "<lWIZARD:<w Yeah, well... I'm rubber and you're glue, so...";
texts[7] = "<lWIZARD:<w Alright, enough talk. I grow weary of talk.";
texts[8] = "<lWIZARD:<w Stay out of my way, or I'll give you super cancer with/my awesome lightning powers.";
texts[9] = "Daaaaamn. Looks like things are getting heated. The two make their way/to the next tower...";
