fade_alpha = 0;
timer[0] = -1;

timer_func[0] = function()
{
    state = !state;
    func_roomend();
    room_goto(myRoom);
};

set = false;
state = 0;
col = 0;
delay = 60;

func_roomend = function()
{
};
