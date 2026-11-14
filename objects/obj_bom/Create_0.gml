col = 0;
event_inherited();
worth = 2;
fat = false;
bom_idle = spr_bom_orange;
bom_edge = spr_bom_orange_edge;
bom_omg = spr_bom_orange_omg;
alarm[0] = 1;
create_explosion_radius = true;

if (global.throw_boms)
    throwable = true;

timer[0] = 840;

timer_func[0] = function()
{
    event_explode();
};

omg_time = 180;
edge_time = 360;
in_tutorial = false;
path_yoff = 28;
set_sprite = false;
landY = -999;
played_explode_anim = false;

event_explode = function()
{
    var _invulnerable = true;
    
    with (obj_player)
    {
        if (!invulnerable)
            _invulnerable = false;
    }
    
    if (!played_explode_anim && !_invulnerable)
    {
        timer[0] = 1;
        anim_play(bom_omg);
        global.freeze = 59940;
        var _anim = instance_create_layer(0, 0, "Transition", obj_bom_explode_anim);
        _anim.my_bom = id;
        played_explode_anim = true;
        exit;
    }
    
    if (global.world == 0)
    {
        audio_play_sound(snd_wrong, 0, 0);
        part_particles_create(global.part_over, x, y - 32, global.particles.smoke, 1);
        var _spawn = instance_create_layer(x, 0, layer, object_index);
        _spawn.col = col;
    }
    else
    {
        if (!throwable)
        {
            with (obj_player)
            {
                hurt_by = other;
                event_user(0);
                timer[timer_invulnerable_flash] = 5;
                invulnerable_flash = true;
                timer[timer_become_vulnerable] = 120;
            }
            
            obj_controller.boms_left--;
        }
        
        var _col;
        
        if (col > 4)
            _col = 0;
        else
            _col = col;
        
        var _sprs = [spr_fx_explosion, spr_fx_explosion_cyan, spr_fx_explosion_purple, spr_fx_explosion_lime, spr_fx_explosion_yellow];
        var _fx = instance_create_layer(x, y - 32, "Particles_Over", obj_fx_explosion);
        _fx.anim_sprite = _sprs[_col];
        
        if (global.throw_boms)
        {
            _fx.image_xscale = 0.2;
            _fx.image_yscale = 0.2;
        }
        
        screen_shake(8, 8);
        audio_play_sound(snd_explosion, 0, 0);
    }
    
    instance_destroy();
};

event_bpm = function()
{
    hey_scale = 1.5;
};

hey_scale = 1;
edge = false;
omg = false;
