event_inherited();
cutscene = "ENDING";
bw_alpha = 0;
my_room = rm_results;
cutscene_sprite = spr_cutscene_ending;
texture_prefetch("tg_cutscene_ending");
bgm_play = noone;
credits_roll = false;

event_on_press = function()
{
    if (slide == (array_length(texts) - 1))
        credits_roll = true;
};

slide_check = function()
{
    if (slide == 1 || slide == 3 || slide == 5 || slide == 7)
    {
        cutscene_index++;
    }
    else if (slide == (array_length(texts) - 1))
    {
        deac = true;
        timer[3] = 60;
        timer[4] = timer[3] + 135;
    }
};

text_y = 0;
go = false;
timer[2] = -1;

timer_func[2] = function()
{
    event_room_end(0, false);
};

timer[3] = -1;

timer_func[3] = function()
{
    bw_fade = true;
};

bw_fade = false;
timer[4] = -1;

timer_func[4] = function()
{
    credits_roll = true;
};

texts[0] = "<lWIZARD:<w NOOO! My evil plan has been foiled!/What are you, some kind of Boom! Buster?";
texts[1] = "<oBUSTER:<w DAMN RIGHT. AND GUESS WHAT? EVERYONE HATES YOU./DON'T YOU GET IT, OLD MAN? I WILL <rKILL<w YOU.";
texts[2] = "<oBUSTER:<w I WILL SKIN YOU ALIVE. I WILL BLOW YOU TO <rF*CKING<w SHREDS./<lWIZARD:<w You'll blow me? Uhh, okay then?";
texts[3] = "<lWIZARD:<w Mark my words, you little punk. I WILL return./And it won't be pretty.";
texts[4] = "<oBUSTER:<w And stay out, you green bastard!";
texts[5] = "<cBRIDGET:<w We did it! We saved the city!";
texts[6] = "<oBUSTER:<w From now on, it will be my sworn duty to protect New York/from all evil to come. I finally have a purpose in life.";
texts[7] = "And so it was said, that Buster and Bridget did an alright job at/saving the city. Some people may even respect them. Hooray!";
texts[8] = "                                                        THE END";
credits = [];
array_push(credits, ["A GAME BY", "Vinny Marsh & Miles Day"]);
array_push(credits, ["VINNY MARSH", "Co-Creator / Co-Director", "Programming", "Game Design", "Level Design", "Writing", "Assistant Character Designer"]);
array_push(credits, ["MILES DAY", "Co-Creator / Co-Director", "Art & Animation", "Lead Character Designer", "Sound Design", "Additional Writing"]);
array_push(credits, ["ART DIRECTION", "Miles Day", "Vinny Marsh"]);
array_push(credits, ["SOUNDTRACK DIRECTION", "Miles Day", "fuzzysmirk", "Vinny Marsh"]);
array_push(credits, ["LEAD COMPOSER", "fuzzysmirk"]);
array_push(credits, ["ADDITIONAL COMPOSITIONS", "Miles Day"]);
array_push(credits, ["CLEANUP ARTIST", "Bianca Ramirez"]);
array_push(credits, ["VOICE ACTING", "Buster: Vinny Marsh", "Bridget: Marissa Lenti", "The Wizard: Jason Marnocha"]);
array_push(credits, ["ADDITIONAL CONTRIBUTIONS", "yunkjardd (Cleanup Assistance)", "Ben \"KewlSokudo\" (Programming Assistance)", "Troopsushi (Game User Interface)"]);
array_push(credits, ["LIBRARIES", "Input: JujuAdams"]);
array_push(credits, ["SPECIAL THANKS", "Meemaw Peepaw", "My Mudda", "My Bruddas", "Troopsushi", "fuzzysmirk", "Bianca", "Ben", "Krz", "Ellie", "Euthie", "Juno", "Josian", "15MinuteGamer", "Anselmo", "Latias", "Fishibi", "Pelo", "ZayJax"]);
array_push(credits, [""]);
array_push(credits, [""]);
array_push(credits, ["...and YOU!"]);
array_push(credits, [""]);
array_push(credits, ["Thanks for playing, broh!"]);
array_push(credits, [""]);
array_push(credits, ["We really put our all into this."]);
array_push(credits, [""]);
array_push(credits, ["Hope you had some fun :)"]);
array_push(credits, [""]);
array_push(credits, ["See you in the next one!"]);
array_push(credits, [""]);
array_push(credits, [""]);
array_push(credits, ["This work may not be used to train artificial intelligence."]);
array_push(credits, ["(c) TALLGLASS 2026"]);
credits_alpha = 1;
fade_out = false;
final_y = undefined;
