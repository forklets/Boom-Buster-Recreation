var _bubbleX = x;
var _bubbleY = y - 52;
var _bubbleScale = 1.1;
var _bubble_xscale, _bubble_yscale;

if (global.bubble)
{
    _bubble_xscale = 1.06 + (sin(current_time / 250) * 0.06);
    _bubble_yscale = 1.06 + (cos(current_time / 250) * 0.06);
    
    if (anim_sprite == spr_buster_dash || anim_sprite == spr_buster_dash_carry)
    {
        _bubble_xscale += 0.35;
        _bubbleX += (16 * facing);
    }
    else if (anim_sprite == spr_buster_backflip)
    {
        _bubbleX -= (12 * facing);
        _bubbleY -= 2;
    }
    else if (anim_sprite == spr_bridget_slide || anim_sprite == spr_bridget_slide_carry)
    {
        _bubble_xscale += 0.14;
        _bubble_yscale -= 0.06;
        _bubbleY += 20;
        
        if (anim_sprite == spr_bridget_slide_carry)
            _bubbleX -= (10 * facing);
    }
    else if (anim_sprite == spr_bridget_dash)
    {
        _bubble_xscale += 0.24;
        _bubble_yscale -= 0.06;
        _bubbleX += (15 * facing);
    }
    
    draw_sprite_ext(spr_slurm_bubble, 0, _bubbleX, _bubbleY, _bubbleScale * _bubble_xscale, _bubbleScale * _bubble_yscale, 0, c_white, 0.2);
}

var _alpha;

if (invulnerable && global.hurt != id && state != state_hurt_coop)
    _alpha = 0.9 - (invulnerable_flash * 0.25);
else
    _alpha = image_alpha;

if (object_index == obj_lightning_effect)
    _alpha = lightning_alpha;

var _cannonscale;

if (my_cannon != noone)
    _cannonscale = my_cannon.scale;
else
    _cannonscale = 1;

var _override;

if (bounce)
    _override = override_facing;
else
    _override = 0;

var _facing;

if (_override != 0)
    _facing = _override;
else
    _facing = facing;

if (anim_sprite == player_skid || anim_sprite == player_skid_carry || anim_sprite == spr_buster_skid_goggles || anim_sprite == spr_bridget_skid_goggles)
    _facing = -_facing;

if (state == state_powerup || anim_sprite == spr_buster_win || anim_sprite == spr_bridget_win || anim_sprite == spr_buster_win_tutorial || anim_sprite == spr_bridget_win_tutorial)
    _facing = 1;

var _angle = 0;

if (instance_exists(my_cannon))
    _angle = my_cannon.image_angle;

var _xscale = xscale_squish * _facing;
var _yscale = yscale_squish * _cannonscale;
var _squish_yoff = 0;

if (squish == squish_jump)
    _squish_yoff = 30 * (yscale_squish - 1);

var _pal;

if (global.throw_boms)
    _pal = 1;
else
    _pal = myPal;

pal_swap(pal_sprite, 0, _pal);
draw_sprite_ext(anim_sprite, anim_index, x, y + pipe_ysin + _squish_yoff, _xscale, _yscale, _angle, image_blend, _alpha);
shader_reset();

if (global.bubble)
    draw_sprite_ext(spr_slurm_bubble, 0, _bubbleX, _bubbleY, _bubbleScale * _bubble_xscale, _bubbleScale * _bubble_yscale, 0, c_white, 0.2);
