draw_set_font(obj_persistent.font_pixel);
selected = 0;
timer[0] = -1;

timer_func[0] = function()
{
    room_goto(my_room);
};

if (global.bside)
    my_room = rm_round_b1;
else
    my_room = rm_round_1;

go = false;
text_header = scr_text_setup(" PLAY TUTORIAL?/");
text_yes = scr_text_setup("YES/");
text_no = scr_text_setup("NO/");
shake = 0;
