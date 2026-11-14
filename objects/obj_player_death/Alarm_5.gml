if (!array_contains(global.bonus_rooms, room))
    alarm[3] = (72 + restart_delay) - 1;

if (player == 0)
{
    if (global.bside)
        global.save.deaths_B++;
    else
        global.save.deaths_A++;
}
