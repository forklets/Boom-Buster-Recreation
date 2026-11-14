event_inherited();
pal_ind += 0.05;

if (pal_ind > sprite_get_width(pal_bom_rainbow))
    pal_ind -= sprite_get_width(pal_bom_rainbow);

if (pal_ind < 1)
    pal_ind = 1;

col = 21;
