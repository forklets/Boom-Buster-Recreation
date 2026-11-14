switch (item)
{
    case obj_bom:
        var _spr = $"spr_bom_{col_to_str(col)}_chute";
        _spr = asset_get_index(_spr);
        anim_play(_spr);
        
        event_explode = function()
        {
            var _inst = instance_create_layer(x, bbox_bottom, layer, obj_bom);
            _inst.col = col;
            
            with (_inst)
                event_explode();
            
            instance_destroy();
        };
        
        break;
}

ready = true;
