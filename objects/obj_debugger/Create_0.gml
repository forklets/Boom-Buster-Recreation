sprite_prefetch(spr_food);
audio_stop_all();
global.player_character[0] = 0;
global.player_character[1] = 1;
global.players = 1;
rooms[0] = [rm_disclaimer, rm_logo, rm_title, rm_charselect, rm_multiplayer_select, rm_playground, rm_bonus_1, rm_bonus_2, rm_bonus_3, rm_final, rm_cutscene_opening, rm_cutscene_city, rm_cutscene_mall, rm_cutscene_factory, rm_cutscene_ending, rm_tileset_setup, rm_tutorial_1, rm_tutorial_2, rm_tutorial_3, rm_tutorial_4, rm_tutorial_5, rm_tutorial_6, rm_tutorial_7, rm_tutorial_ask, rm_results, rm_gotime, rm_youcannow];
rooms[1] = [];
rooms[2] = [];

for (var i = 0; i < array_length(global.stages); i++)
{
    array_push(rooms[1], global.stages[i][0]);
    array_push(rooms[2], global.stages[i][1]);
}

menu = 0;
selected = 0;
global.world = 1;
global.stage = 1;
global.act = 1;
global.stage_type = 0;
global.boss_cutscene = false;
init_game_globals();
