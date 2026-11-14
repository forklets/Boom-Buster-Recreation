debris = [];

new_debris = function()
{
    get_cams(0);
    var _d = 
    {
        x: irandom_range(0, 1600),
        y: 0,
        angle: irandom(359),
        dir: choose(-1, 1),
        scale: random_range(0.5, 0.75),
        vspd: 3,
        grav: 0.7,
        frame: irandom(sprite_get_number(spr_tower_wall_shards) - 1),
        life: 0
    };
    array_push(debris, _d);
};

time = 0;
