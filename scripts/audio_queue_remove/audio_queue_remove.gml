function audio_queue_remove(arg0)
{
    for (var i = 0; i < ds_list_size(global.audio_queues); i++)
    {
        if (ds_list_find_value(global.audio_queues, i) == arg0)
            ds_list_delete(global.audio_queues, i);
    }
}
