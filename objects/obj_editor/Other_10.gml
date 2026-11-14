toggle_text = ["Wings", "Fat", "Toggle Pause On Sort", "Parachute", "", "", "", ""];

row_func[0] = function()
{
    var _element;
    
    if (element_selected != noone)
        _element = global.elements[element_selected];
    
    if (element_selected != noone)
    {
        if (!struct_exists(_element, "wings"))
            _element.wings = false;
        
        _element.wings = !_element.wings;
    }
};

row_func[1] = function()
{
    var _element;
    
    if (element_selected != noone)
        _element = global.elements[element_selected];
    
    if (element_selected != noone)
    {
        if (!struct_exists(_element, "fat"))
            _element.fat = false;
        
        _element.fat = !_element.fat;
    }
};

row_func[2] = function()
{
    var _element;
    
    if (element_selected != noone)
        _element = global.elements[element_selected];
    
    if (element_selected != noone)
    {
        if (!struct_exists(_element, "toggle_pause"))
            _element.toggle_pause = false;
        
        _element.toggle_pause = !_element.toggle_pause;
    }
};

row_func[3] = function()
{
    var _element;
    
    if (element_selected != noone)
        _element = global.elements[element_selected];
    
    if (element_selected != noone)
    {
        if (!struct_exists(_element, "chute"))
            _element.chute = false;
        
        _element.chute = !_element.chute;
    }
};

if (element_selected != noone)
{
    var _row = global.elements[element_selected].row;
    
    if (_row == 0 || _row == 2 || _row == 7)
    {
        row_func[4] = function()
        {
        };
        
        row_func[5] = function()
        {
        };
        
        draw_columns(spr_editor_toggles, 0, true);
        draw_text(10 + global.app_xoff, 970, toggle_text_draw);
    }
}
