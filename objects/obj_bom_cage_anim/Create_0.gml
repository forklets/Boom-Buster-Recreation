anim_init();

event_animend = function()
{
    var _spr = anim_sprite;
    
    if (_spr == spr_bom_cage_bounce)
        anim_play(spr_bom_cage_idle);
};

eyes_sprite = noone;
eyes_index = 0;

eyes_play = function(arg0)
{
    if (eyes_sprite != arg0)
    {
        eyes_sprite = arg0;
        eyes_index = 0;
    }
};

event_eyes_animend = function()
{
    var _spr = eyes_sprite;
    
    if (_spr == spr_bom_cage_eyes_open)
    {
        eyes_play(spr_bom_cage_eyes);
        timer[1] = 90;
    }
    else if (_spr == spr_bom_cage_eyes_close)
    {
        eyes_sprite = noone;
        timer[2] = 10;
    }
};

timer[0] = 60;

timer_func[0] = function()
{
    eyes_play(spr_bom_cage_eyes_open);
};

timer[1] = -1;

timer_func[1] = function()
{
    eyes_play(spr_bom_cage_eyes_close);
};

timer[2] = -1;

timer_func[2] = function()
{
    event_bounce();
};

event_bounce = function()
{
    vspd = -5;
    anim_play(spr_bom_cage_bounce);
    scale_percent = 0;
};

sprite_set_speed(spr_bom_cage_bounce, 23, 0);
scale_percent = 1;
xscale = 1;
yscale = 1;
vspd = 0;
grav = 0.27;
yoff = 0;
angle = 0;
bounces = 0;
bounce_state = -1;

event_yoff_land = function()
{
    var _xmin = -18;
    var _xmax = 18;
    var _count = 4;
    var _div = (_xmax - _xmin) / _count;
    var _xpos = [];
    
    for (var i = 0; i < _count; i++)
        _xpos[i] = _xmin + (_div * i);
    
    for (var i = 0; i < _count; i++)
    {
        var _x = x + _xpos[i];
        var _y = (y - 14) + irandom_range(0, 6) + 9;
        var _dust = instance_create_layer(_x, _y, "Particles_Over", obj_fx_dust);
        
        if (_x > x)
            _dust.hspd = random_range(2, 5) * 0.6;
        else
            _dust.hspd = random_range(-2, -5) * 0.6;
        
        var _scale = random_range(1.1, 1.3) * 0.9;
        _dust.image_xscale = _scale;
        _dust.image_yscale = _scale;
        _dust.image_alpha_override = 0.6;
        _dust.grav = -0.0725;
    }
    
    bounces++;
    
    if (bounces < 2)
    {
        timer[2] = 2;
        anim_sprite = spr_bom_cage_idle;
    }
    else
    {
        timer[0] = 60;
        bounce_state = -1;
        bounces = 0;
        scale_percent = 0;
    }
};

state = 0;
col = -1;
flash = 0;
