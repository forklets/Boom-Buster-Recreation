room_index++;

if (room_index < array_length(rooms))
    room_goto(rooms[room_index]);
else
{
    instance_destroy();
    room_goto(rm_disclaimer);
}
