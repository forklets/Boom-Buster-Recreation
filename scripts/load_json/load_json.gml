function load_json(arg0)
{
    if (!file_exists(arg0))
    {
        show_message($"File not found: {arg0}\nDid you remove it? Tsk tsk...");
        game_end();
        return undefined;
    }

    var _file = file_text_open_read(arg0);

    var _json_content = "";
    
    while (!file_text_eof(_file))
    {
        _json_content += file_text_read_string(_file);
        file_text_readln(_file);
    }
    
    file_text_close(_file);
    return json_parse(_json_content);
}
