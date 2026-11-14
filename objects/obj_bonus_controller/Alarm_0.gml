global.freeze = 0;

for (var i = 0; i < array_length(freeze_objects); i++)
{
    with (freeze_objects[i])
        bonus_freeze = true;
}
