ready = true;
var _strs = 
{
    rm_tutorial_1: ["Press <Z to jump/Press <Z mid-air to double jump/", "Press <X to spin/"],
    rm_tutorial_2: ["Hold <D to crouch/Jump <Z while crouching to backflip/"],
    rm_tutorial_3: ["Press <C mid-air to air-dash/", "Press <C on ground to slide/"],
    rm_tutorial_4: ["Touch a BOM to pick it up/Spin <X to toss it into the pipe/"],
    rm_tutorial_5: ["Gently set an item down/by holding <D while spinning <X/", "Collect slime to calm BOMs down from exploding./This is helpful for getting combos, too!/"],
    rm_tutorial_6: ["Stack same-colored BOMs/for higher combos/"],
    rm_tutorial_7: ["Slime <0 and combos fill/up the shield meter./When the meter is full,/press <S for a shield./", "Slime <0 also gives BOMs extra time./Useful for higher combos!/"]
};

if (struct_exists(_strs, room_get_name(room)))
    str = struct_get(_strs, room_get_name(room))[string_index];

str = string_upper(str);
draw_set_font(obj_persistent.font_pixel);
text_draw = scr_text_setup(str);
