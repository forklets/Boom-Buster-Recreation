function anim_init()
{
    anim_sprite = sprite_index;
    anim_index = 0;
    anim_speed = 1;
    override_sprite = noone;
    
    event_animend = function()
    {
        if (override_sprite != noone)
            override_sprite = noone;
        
        exit;
    };
    
    image_speed = 0;
}
