event_inherited();

if (!global.save.campaign_beat_A)
{
    options[1] = "???";
}
else
{
    var _side;
    
    if (global.bside)
        _side = "B";
    else
        _side = "A";
    
    var _str = $"SIDE: {_side}";
    options[1] = _str;
}

if (global.bside)
    options[0] = "WIZARD'S REVENGE";
else
    options[0] = "CAMPAIGN";
