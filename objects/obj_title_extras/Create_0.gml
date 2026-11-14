event_inherited();
options = ["PALETTES", "THEATER", "HOW TO PLAY", "BACK"];

var _achievements = function()
{
    var _inst = instance_create_layer(0, 0, layer, obj_achievements);
};

var _theater = function()
{
    input_verb_consume_all("jump");
    instance_create_layer(0, 0, layer, obj_theater);
    instance_destroy();
};

var _delete = function()
{
};

var _howto = function()
{
    instance_create_layer(0, 0, layer, obj_howtoplay);
    deac = true;
};

var _back = function()
{
    input_verb_consume_all("jump");
    instance_destroy();
};

var _stats = function()
{
};

options_event = [_achievements, _theater, _howto, _back];
xoff = 729;
yoff = -158;
box = false;
ready = true;
options_draw_max = array_length(options);
