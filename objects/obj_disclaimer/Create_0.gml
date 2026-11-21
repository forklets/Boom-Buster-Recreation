event_inherited();
texture_prefetch("tg_title");
my_room = rm_logo;
global.bgm_play = audio_play_sound(bgm_title, 0, true);
timer[0] = 240;
splashes = ["The first home computer was built in hopes we would make BOOM! Buster.\nThis was always meant to be.", "BOOM! Buster is based off BOM! Buster,\na Japanese Arcade-Cabinet release from 1988.\nNot really. That's a lie.", "BOOM! Buster is the first ever video game.\nLook it up. It's true.", "If you think this game is kind of weird or something,\nyou can reach our support team at\nSuperBusterBrothersDotCom.", "Hi", "Welcome to Boom! Buster,\nI love you", "When you love yourself, other people\nbegin to love you even more.", "Killing people in the real world is immoral.\nThankfully, video games are a form of escapism.", "Feeling scared is a good thing.\nDon't let it stop you.\nAlways kill the Wizard."];
timer[0] = 390;
splash = splashes[irandom_range(0, array_length(splashes) - 1)];
hue = 0;
