deac = false;
surf = noone;
achievements = [];
struct_foreach(global.achievements, function(arg0, arg1)
{
    array_push(achievements, variable_struct_get(global.achievements, arg0));
});
buster_spr = spr_buster_idle;
buster_ind = irandom_range(0, 10);
bridget_spr = spr_bridget_idle;
bridget_ind = buster_ind;

for (var i = 0; i < (sprite_get_width(pal_buster) - 2); i++)
    pals[i] = "NOT SET";

pals_bu[0] = ["Buster", -4];
pals_bu[1] = ["Bro", "DIE"];
pals_bu[2] = ["Maurice", "TOWER_1"];
pals_bu[3] = ["Outback", "TOWER_2"];
pals_bu[4] = ["GameBruh", "TOWER_3"];
pals_bu[5] = ["Lover", "OUTSKIRTS"];
pals_bu[6] = ["Hater", "BUZZSAW"];
pals_bu[7] = ["Big Mike", "COMBO_5"];
pals_bu[8] = ["Bubblegum", "COMBO_7"];
pals_bu[9] = ["Birthday Suit", "DUD"];
pals_bu[10] = ["That's not funny, Buster", "LIGHTNING"];
pals_bu[11] = ["Mmmm...", "FIRE"];
pals_bu[12] = ["Off My Lawn", "THE_END"];
pals_bu[13] = ["Baby Bones", "BONUS_1"];
pals_bu[14] = ["Chicken Paaam", "FOOD"];
pals_bu[15] = ["Mr. Bulldops", "BONUS_2"];
pals_bu[16] = ["AAAAAAAAAAAAAAAAAAAA", "BOOM_BUSTER"];
pals_br[0] = ["Bridget", -4];
pals_br[1] = ["Bro 2", "TOWER_1B"];
pals_br[2] = ["What's Not To Love", "TOWER_2B"];
pals_br[3] = ["Dog In Da White House", "TOWER_3B"];
pals_br[4] = ["GameGirl", "OUTSKIRTS_B"];
pals_br[5] = ["Lover", "THE_END_B"];
pals_br[6] = ["Pizza Stealing Heart", "WIZARD_BRIDGET"];
pals_br[7] = ["The Magic", "BONUS_1B"];
pals_br[8] = ["Bubblegum", "BONUS_2B"];
pals_br[9] = ["Pointy Pixels", "FOOD_B"];
pals_br[10] = ["Rockstar", "BONUS_3B"];
pals_br[11] = ["Yellow Mother", "BONUS_3"];
pals_br[12] = ["Beep Boop I Am A Robot", "WIN_DEATH_30"];
pals_br[13] = ["NGAHHH!", "WIN_DEATH_15"];
pals_br[14] = ["You Only Live Once", "WIN_DEATH_5"];
pals_br[15] = ["Aw Jeez", "WIN_DEATH_0"];
pals_br[16] = ["AAAAAAAAAAAAAAAAAAAA", "BOOM_BUSTER"];
selected = global.palette[global.player_character[0]];
menu_yoff = 0;
menu_sep = 135;
bg_pos = 0;
effect_scale = 1;
effect_alpha = 0;

set_menu_yoff = function(arg0 = false)
{
    var _selected = selected;
    _selected = clamp(_selected, 3, array_length(pals) - 4);
    var _to = -_selected * menu_sep;
    
    if (_selected == (array_length(pals) - 4))
        _to -= 40;
    
    menu_yoff = easy_smooth(menu_yoff, _to, 4);
    
    if (arg0)
        menu_yoff = _to;
};

set_menu_yoff(true);

check_unlocked = function(arg0, arg1)
{
    var _got = false;
    var _str;
    
    if (is_array(arg0[arg1]))
    {
        if (arg0[arg1][1] == -4 || variable_struct_get(global.achievements, arg0[arg1][1]).got)
        {
            _got = true;
            _str = arg0[arg1][0];
        }
        else
        {
            _got = false;
        }
    }
    else
    {
        _str = arg0[arg1];
    }
    
    if (!_got)
        _str = "???";
    
    return [_got, _str];
};

timer[0] = irandom_range(300, 420);

timer_func[0] = function()
{
    buster_ind = 0;
    bridget_ind = 0;
    buster_spr = spr_buster_taunt;
    bridget_spr = spr_bridget_taunt;
    timer[0] = irandom_range(360, 600);
};

event_animend_buster = function()
{
    var _spr = buster_spr;
    
    if (_spr == spr_buster_taunt)
    {
        buster_spr = spr_buster_idle;
        buster_ind = 0;
    }
};

event_animend_bridget = function()
{
    var _spr = bridget_spr;
    
    if (_spr == spr_bridget_taunt)
    {
        bridget_spr = spr_bridget_idle;
        bridget_ind = 0;
    }
};
