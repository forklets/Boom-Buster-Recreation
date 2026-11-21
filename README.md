# boom buster recreation

changed the title to make it sound less petty..

decomp of boom buster with all the art and audio taken out. you need your own copy of the game to put them back in, there's a script for it below.

i was speedrunning making this decomp so things may not work

pls credit me if u use this, thanks ^_^ totally star this repo too if u can

## what you need

- boom buster on steam
- [undertalemodtool](https://github.com/UnderminersTeam/UndertaleModTool) 0.9.0.0 or newer
- gamemaker lts 2026

## getting the assets

1. open utmt and load `data.win` from your game folder (usually `steamapps/common/BOOM BUSTER/data.win`). keep `ag_bgm.dat` next to it, the music is in there
2. go to `scripts > run other script...` and pick `tools/gather_assets.csx` from this repo
3. it finds the project folder on its own since the script is inside it. if it can't it'll ask, pick the folder with `BusterBeta.yyp` in it
4. wait like 20 seconds, you get a popup when it's done

it should say around 7690 files. that's the art, sounds and fonts, plus any stage/ghost files in `datafiles` that are different in your game folder. this is all synced to the 1.0.8.3 update (the lag fix one), so if your game is older update it on steam first or some of the backgrounds will come out wrong.

## running it

open `BusterBeta.yyp` in gamemaker and hit run.

debug mode is on by default (`global.debug` in `obj_persistent`'s create event). turn it off if you want it to act like the real game. while it's on:

- f12 is room select
- f1 opens the level editor
- f3 toggles the overlay
- f10 dumps resource counts to the output log
- hold shift when a stage loads to pick a stage json yourself

## heads up

- the assets are in `.gitignore` so you won't commit them by accident. please don't force add them

## license

the game and everything in it belongs to tallglass, this repo doesn't give you any rights to it. the third party stuff (input, the sdl controller db, etc) keeps its own license. see `LICENSE` and `THIRD_PARTY_LICENSES.txt`.
