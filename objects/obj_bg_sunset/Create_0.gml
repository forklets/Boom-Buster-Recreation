event_inherited();

if (array_contains(global.wizard_events_total, room) && !array_contains(global.wizard_events_total, global.last_room))
{
    global.dome = false;
    global.dome_alpha = 0;
    global.dome_ind = -1;
    global.dome_timer = 300;
    global.dome_order = [];
    
    for (var i = 0; i < sprite_get_number(bgr_city_sunset_dome_wizard); i++)
        global.dome_order[i] = i;
    
    global.dome_order = array_shuffle(global.dome_order);
}

bg_script = scr_bg_sunset;
clouds_x = 0;
timer[0] = global.dome_timer;

timer_func[0] = function()
{
    global.dome = !global.dome;
    
    if (global.dome)
    {
        timer[0] = 1200;
        global.dome_ind++;
        var _wizard = array_contains(global.wizard_events_total, room);
        var _spr = bgr_city_sunset_dome;
        
        if (_wizard)
            _spr = bgr_city_sunset_dome_wizard;
        
        if (global.dome_ind >= sprite_get_number(_spr))
        {
            var _last = [];
            array_copy(_last, 0, global.dome_order, 0, array_length(global.dome_order));
            
            for (var i = 0; i < sprite_get_number(_spr); i++)
                global.dome_order[i] = i;
            
            global.dome_order = array_shuffle(global.dome_order);
            global.dome_ind = 0;
            
            if (global.dome_order[0] == _last[array_length(_last) - 1])
                global.dome_ind++;
        }
    }
    else
    {
        timer[0] = 300;
    }
};

var _layer = layer_create(layer_get_depth(layer_get_id("GUI")) + 10, "Tint");
var _fx_tint = fx_create("_filter_tintfilter");
fx_set_parameter(_fx_tint, "g_TintCol", [0.9372549019607843, 0.8, 0.8901960784313725, 1]);
fx_set_single_layer(_fx_tint, false);
layer_set_fx(_layer, _fx_tint);
