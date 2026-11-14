event_inherited();
bside_last = global.bside;
global.bside = false;
bside = false;
my_room = noone;
gone = false;

event_back = function()
{
    var _inst = instance_create_layer(0, 0, layer, obj_title_extras);
    _inst.selected = 1;
    global.bside = bside_last;
    instance_destroy();
};

var _opening = function()
{
    my_room = rm_cutscene_opening;
};

var _city = function()
{
    my_room = rm_cutscene_city;
};

var _mall = function()
{
    my_room = rm_cutscene_mall;
};

var _factory = function()
{
    my_room = rm_cutscene_factory;
};

var _cityB = function()
{
    my_room = rm_cutscene_city;
    bside = true;
};

var _mallB = function()
{
    my_room = rm_cutscene_mall;
    bside = true;
};

var _factoryB = function()
{
    my_room = rm_cutscene_factory;
    bside = true;
};

var _ending = function()
{
    my_room = rm_cutscene_ending;
};

var _back = function()
{
    event_back();
};

options = ["OPENING", "CITY", "MALL", "FACTORY", "CITY (B)", "MALL (B)", "FACTORY (B)", "ENDING", "BACK"];
options_event = [_opening, _city, _mall, _factory, _cityB, _mallB, _factoryB, _ending, _back];

for (var i = 0; i < (array_length(options) - 1); i++)
{
    if (!array_contains(global.save.cutscenes_watched, options[i]))
        options[i] = "???";
}

xoff = 729;
yoff = -158;
box = false;
ready = true;
options_draw_max = array_length(options);
