if (global.save.campaign_beat_A)
    skip_alpha = 2.2;
else
    skip_alpha = 0;

if (global.theater == noone && room != rm_cutscene_opening)
{
    with (obj_persistent)
        event_save();
}

event_room_end = function(arg0, arg1 = true)
{
    var _room;
    
    if (global.theater != noone)
    {
        _room = rm_title;
    }
    else if (global.save.campaign_beat_A && object_index != obj_cutscene_ending)
    {
        global.next_room = my_room;
        _room = rm_charselect;
    }
    else
    {
        _room = my_room;
    }
    
    if (arg1)
        room_goto_fade(_room, arg0);
    else
        room_goto(_room);
};

if (object_index != obj_cutscene_ending)
    audio_stop_all();

texture_prefetch("tg_cutscene");
cutscene_sprite = spr_cutscene_opening;
draw_cutscene = true;
bgm_play = noone;
slide = 0;
cutscene_index = 0;
deac = false;
arrow_move_delay = 15;
timer[0] = arrow_move_delay;

timer_func[0] = function()
{
    arrow_move = !arrow_move;
    timer[0] = arrow_move_delay;
};

arrow_move = false;
timer[1] = -1;

timer_func[1] = function()
{
    deac = false;
    slide++;
    slide_check();
};

texts = [];
text_sep = 210;
text_ystart = 916;
text_xstart = 92;
scale = 2.44;
xscale = 0.75;
yscale = 0.95;
blank_width = 7.5;

event_on_press = function()
{
};

slide_check = function()
{
};

y = 0;
