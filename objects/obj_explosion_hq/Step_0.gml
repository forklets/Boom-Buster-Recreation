anim_logic();

if (!left && anim_index >= 8)
{
    room_goto(rm_title);
    left = true;
}

if (anim_index >= 25)
{
    image_alpha = approach(image_alpha, 0, 0.08);
    scale -= 0.05;
}

scale = easy_smooth(scale, 5, 4);
