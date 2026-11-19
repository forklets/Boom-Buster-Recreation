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
3. it'll ask for a folder, pick this repo's folder (the one with `BusterBeta.yyp` in it)
4. wait like 2 minutes. you get a popup when it's done and it leaves a `gather_assets_log.txt` in the folder

it should say it wrote 7626 files with one warning about `tst_test`. that one's fine, the game doesn't have an image for it so you get a blank one.

## running it

open `BusterBeta.yyp` in gamemaker and hit run.

debug mode is on by default (`global.debug` in `obj_persistent`'s create event). turn it off if you want it to act like the real game. while it's on:

- f12 is room select
- f1 opens the level editor
- f3 toggles the overlay
- hold shift when a stage loads to pick a stage json yourself

## heads up

- the assets are in `.gitignore` so you won't commit them by accident. please don't force add them

## license

the game and everything in it belongs to tallglass, this repo doesn't give you any rights to it. the third party stuff (input, the sdl controller db, etc) keeps its own license. see `LICENSE` and `THIRD_PARTY_LICENSES.txt`.
