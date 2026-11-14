if (shattered)
    exit;

if (place_meeting(x, y, obj_explosion_radius))
    event_shatter();
