player = 0;
physics_init();
bounce_mult = 0.4;
anim_init();
xscale_squish = 1;
yscale_squish = 1;
carry_yoff = 0;
facing = 1;
caged = false;
collected = false;
throwable = false;
ignore = -4;
ignore_timer = 0;
carried = -4;
carried_tossY = -999;
tossed = false;
thrown = false;
throw_now = false;
dropped = false;
landYobj = -4;
landY = -999;
tossY = -999;
collide_with_ceiling = false;
landed = false;
inPipe = -4;
abrupt_land = false;
hspd_bounce = 0;
array_push(move_forces[0], "hspd_bounce");
wings = false;
time = 0;
wings_sin = 0;
wing_ind = 0;

event_wings_away = function()
{
    var _inst = instance_create_depth(x, y, layer_get_depth(layer) + 1, obj_wings_away);
    _inst.anim_index = wing_ind;
    wings = false;
};

wing_width = 38;
wing_yoff = -29;

event_floor = function()
{
    if (thrown)
    {
        event_impact();
        exit;
    }

    if (inPipe)
    {
        var _jump = -6;
        vspd = choose(_jump, _jump * 1.3, _jump * 1.6);
        exit;
    }

    var _vspd = vspd;
    var _tossed = tossed;
    var _dropped = dropped;

    if (place_meeting(x, y + 1, obj_movingsemi) || place_meeting(x, y + 1, obj_conveyor) || place_meeting(x, y + 1, obj_conveyor_semi))
    {
        var _fine = false;

        if (place_meeting(x, y + 1, obj_movingsemi))
        {
            var _inst = instance_place(x, y + 1, obj_movingsemi);

            if (_inst.hspd == 0 && _inst.vspd == 0)
                _fine = true;
        }

        if (!_fine)
        {
            if (vspd >= 14)
                part_particles_create(global.part_over, x, y, global.particles.dustland, 1);

            vspd = 0;
            exit;
        }
    }

    if (_dropped || abrupt_land)
    {
        hspd_bounce = random_range(-4, 4);
        dropped = false;
        abrupt_land = false;
    }

    if (_vspd >= 2)
    {
        vspd = -_vspd * bounce_mult;

        if (_vspd >= 14)
            part_particles_create(global.part_over, x, y, global.particles.dustland, 1);
    }
    else
        vspd = 0;
};

event_ymove = function()
{
    if (tossed && (place_meeting(x, y + 1, obj_caution_solid) || place_meeting(x, y + 1, obj_caution_semisolid)))
    {
        var _list = ds_list_create();
        instance_place_list(x, y + 1, obj_caution_solid, _list, false);
        var _blocked = false;

        for (var i = 0; i < ds_list_size(_list); i++)
        {
            var _inst = ds_list_find_value(_list, i);

            if (carried_tossY <= _inst.y)
            {
                with (ds_list_find_value(_list, i))
                    event_user(0);

                _blocked = true;
            }
        }

        ds_list_destroy(_list);
        _list = ds_list_create();
        instance_place_list(x, y + 1, obj_caution_semisolid, _list, false);

        for (var i = 0; i < ds_list_size(_list); i++)
        {
            var _inst = ds_list_find_value(_list, i);

            if (carried_tossY <= _inst.y)
            {
                with (ds_list_find_value(_list, i))
                    event_user(0);

                _blocked = true;
            }
        }

        ds_list_destroy(_list);

        if (_blocked)
        {
            tossed = false;
            thrown = false;
            has_collision = true;
            abrupt_land = true;
            event_floor();
            landY = -999;
            ignore_timer = -1;
            ignore = -4;
            return false;
        }
    }

    if (mypath != -4 && !on_path && y >= landY)
    {
        on_path = true;
        x = path_get_x(mypath, path_pos);
        y = path_get_y(mypath, path_pos);
        return false;
    }

    if (mypath == -4 && y >= landY && !solid_meeting(x, y, obj_solid))
    {
        has_collision = true;
        landY = -999;
        landYobj = -4;
    }

    return true;
};

event_bounce_extra = function()
{
    landY = -999;
    landYobj = -4;
};

timer[1] = -1;

timer_func[1] = function()
{
    if (array_contains(global.stages_final, room) && obj_controller.final_ended)
        grav = 0;
    else
        grav = 0.4;
};

throw_grav_delay = 3;
timer[2] = -1;

timer_func[2] = function()
{
    flicker = !flicker;
};

flicker = false;
flicker_animation = true;
life = 450;
limited_life = false;

event_wall = function()
{
    if (thrown)
        event_impact();

    if (throwable && ignore != -4)
    {
        ignore = -4;
        ignore_timer = -1;
    }

    hspd = -hspd;
};

path_init();
create_explosion_radius = false;

event_impact = function()
{
    if (create_explosion_radius)
    {
        var _inst = instance_create_layer(x, y, "Instances", obj_explosion_radius);
        _inst.image_xscale = 2.5;
        _inst.image_yscale = 2.5;
    }

    var _col;

    if (col > 4)
        _col = 0;
    else
        _col = col;

    var _sprs = [spr_fx_explosion, spr_fx_explosion_cyan, spr_fx_explosion_purple, spr_fx_explosion_lime, spr_fx_explosion_yellow];
    var _fx = instance_create_layer(x, y - 32, "Particles_Over", obj_fx_explosion);
    _fx.anim_sprite = _sprs[_col];

    if (array_contains(global.stages_final, room))
    {
        _fx.image_xscale = 0.75;
        _fx.image_yscale = 0.75;
        _fx.loop_die = 2;
    }

    screen_shake(8, 8);
    var _snd = audio_stop_play(snd_explosion, 0, 0);
    audio_sound_gain(_snd, 0.85, 0);
    instance_destroy();
};

draw_xoff = 0;
draw_yoff = 0;

draw_me = function(arg0 = image_blend, arg1 = image_alpha)
{
    if (!caged)
        draw_sprite_ext(anim_sprite, anim_index, x + draw_xoff, y + carry_yoff + wings_sin + draw_yoff + pipe_ysin, facing * xscale_squish, yscale_squish, 0, arg0, arg1);
};

pal_sprite = -4;
pal_ind = 0;
flash_nuclear_alpha = 0;
xoff = 0;
yoff = 0;
yoff_length = 12;

init_bounce_values = function()
{
    bounce = false;
    bounce_count = 0;
    carrier_vspd_last = 0;
    last_fall_vspd = 0;
    fall_yoff = 0;
    bounce_yoff = 0;
    bounce_vspd = 0;
    fall_yoff_extra = 0;
    array_lag = [];
    fall_smooth = false;
};

init_bounce_values();

event_grabbed = function(arg0)
{
    carried = arg0.id;
    mypath = -4;

    if (wings)
        event_wings_away();

    on_path = false;
    carry_yoff = 16;
    wings_sin = 0;
};

hammered = false;
toggle_pause = false;
pipe_add_bom = true;
worth = 1;
