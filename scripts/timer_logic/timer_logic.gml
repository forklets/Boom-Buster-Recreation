function timer_logic(arg0)
{
    if (timer[arg0] > -1)
    {
        var _time = timer[arg0];
        timer[arg0]--;
        
        if (timer[arg0] <= 0 && _time > 0)
            timer_func[arg0]();
    }
}
