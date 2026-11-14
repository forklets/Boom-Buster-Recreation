if (exit_freeze())
    exit;

get_cams(0);
y = camy;
time--;

if (time <= -1)
{
    new_debris();
    time = irandom_range(10, 60);
}
