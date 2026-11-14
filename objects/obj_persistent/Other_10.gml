print($"BGM:{global.bgm_vol}");
print($"SFX:{global.sfx_vol}");
print($"Master:{global.master_vol}");
var _volSFX = global.sfx_vol * global.master_vol;
var _volBGM = global.bgm_vol * global.master_vol;
print($"_volSFX:{_volSFX}");
print($"_volBGM:{_volBGM}");

for (var i = 0; i < array_length(musics); i++)
{
    var _snd = asset_get_index(musics[i][0]);
    var _vol = musics[i][1];
    print($"musics[i] {_volBGM * _vol}");
    audio_sound_gain(_snd, _volBGM * _vol, 0);
}

for (var i = 0; i < array_length(sounds); i++)
{
    var _snd = asset_get_index(sounds[i][0]);
    var _vol = sounds[i][1];
    audio_sound_gain(_snd, _volSFX * _vol, 0);
}
