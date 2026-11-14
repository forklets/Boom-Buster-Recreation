if (instance_exists(obj_options))
    exit;

var _strs = ["CONFIRM", "BACK"];
var _glyphs = ["Z", "B"];

if (input_source_using(__input_global().__source_keyboard, 0))
    _glyphs[1] = "X";

for (var i = 0; i < 2; i++)
{
    var _scale = 0.72;
    var _x = 1130 + box_x;
    var _y = 865;
    
    if (i == 1)
        _x += 450;
    
    draw_glyph(_glyphs[i], _x, _y, _scale, _scale);
    draw_set_font(obj_persistent.font_pixel);
    draw_text_transformed(_x + 63, _y + 13, _strs[i], _scale * 2.5, _scale * 2.5, 0);
}
