var _inst = obj_cutscene_factory;

if (global.bside)
    _inst = obj_cutscene_factoryB;

instance_create_layer(0, 0, "Instances", _inst);
