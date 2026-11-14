function input_verb_consume_all(arg0)
{
    var _bool = false;
    
    for (var i = 0; i < 2; i++)
        input_verb_consume(arg0, i);
    
    return _bool;
}
