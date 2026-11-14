// pulls the sprites, tilesets, fonts and sounds out of your copy of boom buster and puts them in the project
// needs undertalemodtool 0.9.0.0 or newer
//
// 1. open the game's data.win in utmt (keep ag_bgm.dat next to it)
// 2. scripts > run other script... > pick this file
// 3. when it asks, pick the project folder (the one with BusterBeta.yyp in it)

using System;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Text.RegularExpressions;
using System.Collections.Generic;
using System.Threading.Tasks;
using ImageMagick;
using UndertaleModLib.Util;

EnsureDataLoaded();

ScriptMessage("pick the boom buster project folder next (the one with BusterBeta.yyp in it)");
string projectDir = PromptChooseDirectory();
if (projectDir is null)
    return;

if (!File.Exists(Path.Combine(projectDir, "BusterBeta.yyp")))
{
    ScriptError("couldn't find BusterBeta.yyp in that folder. pick the project folder itself, not one inside it");
    return;
}

string gameDir = Path.GetDirectoryName(FilePath);
var jsonOptions = new JsonDocumentOptions { AllowTrailingCommas = true, CommentHandling = JsonCommentHandling.Skip };
var missing = new List<string>();
var warnings = new List<string>();
int written = 0;

var dataSprites = Data.Sprites.Where(s => s?.Name is not null).GroupBy(s => s.Name.Content, StringComparer.OrdinalIgnoreCase).ToDictionary(g => g.Key, g => g.First(), StringComparer.OrdinalIgnoreCase);
var dataSounds = Data.Sounds.Where(s => s?.Name is not null).GroupBy(s => s.Name.Content, StringComparer.OrdinalIgnoreCase).ToDictionary(g => g.Key, g => g.First(), StringComparer.OrdinalIgnoreCase);
var dataFonts = Data.Fonts.Where(f => f?.Name is not null).GroupBy(f => f.Name.Content, StringComparer.OrdinalIgnoreCase).ToDictionary(g => g.Key, g => g.First(), StringComparer.OrdinalIgnoreCase);
var dataTilesets = Data.Backgrounds.Where(b => b?.Name is not null).GroupBy(b => b.Name.Content, StringComparer.OrdinalIgnoreCase).ToDictionary(g => g.Key, g => g.First(), StringComparer.OrdinalIgnoreCase);

JsonElement ReadYY(string path)
{
    using var doc = JsonDocument.Parse(File.ReadAllText(path), jsonOptions);
    return doc.RootElement.Clone();
}

List<string> Names(JsonElement yy, string arrayKey)
{
    var list = new List<string>();
    if (yy.TryGetProperty(arrayKey, out JsonElement arr) && arr.ValueKind == JsonValueKind.Array)
        foreach (JsonElement e in arr.EnumerateArray())
            list.Add(e.GetProperty("name").GetString());
    return list;
}

IEnumerable<string> AssetDirs(string type)
{
    string dir = Path.Combine(projectDir, type);
    if (!Directory.Exists(dir))
        return Enumerable.Empty<string>();
    return Directory.GetDirectories(dir).Where(d => File.Exists(Path.Combine(d, Path.GetFileName(d) + ".yy")));
}

MagickImage Blank(int width, int height) => new MagickImage(MagickColor.FromRgba(0, 0, 0, 0), (uint)Math.Max(width, 1), (uint)Math.Max(height, 1));

IMagickImage<byte> FitTo(IMagickImage<byte> img, int width, int height)
{
    if ((int)img.Width == width && (int)img.Height == height)
        return img;
    var canvas = Blank(width, height);
    canvas.Composite(img, 0, 0, CompositeOperator.Copy);
    img.Dispose();
    return canvas;
}

void SaveSpriteFrames(string spriteDir, JsonElement yy, Func<int, IMagickImage<byte>> getFrame)
{
    var frames = Names(yy, "frames");
    var layers = Names(yy, "layers");
    for (int i = 0; i < frames.Count; i++)
    {
        string framePath = Path.Combine(spriteDir, frames[i] + ".png");
        using (IMagickImage<byte> img = getFrame(i))
            TextureWorker.SaveImageToFile(img, framePath);
        written++;

        foreach (string layer in layers)
        {
            string layerDir = Path.Combine(spriteDir, "layers", frames[i]);
            Directory.CreateDirectory(layerDir);
            File.Copy(framePath, Path.Combine(layerDir, layer + ".png"), true);
            written++;
        }
    }
}

var tilesetSprites = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
foreach (string dir in AssetDirs("tilesets"))
{
    JsonElement yy = ReadYY(Path.Combine(dir, Path.GetFileName(dir) + ".yy"));
    if (yy.TryGetProperty("spriteId", out JsonElement sid) && sid.ValueKind == JsonValueKind.Object)
        tilesetSprites.Add(sid.GetProperty("name").GetString());
}

var spriteDirs = AssetDirs("sprites").ToList();
var soundDirs = AssetDirs("sounds").ToList();
var fontDirs = AssetDirs("fonts").ToList();
var tilesetDirs = AssetDirs("tilesets").ToList();

SetProgressBar(null, "Gathering assets", 0, spriteDirs.Count + soundDirs.Count + fontDirs.Count + tilesetDirs.Count);
StartProgressBarUpdater();

await Task.Run(() =>
{
    using TextureWorker worker = new();

    foreach (string dir in spriteDirs)
    {
        string name = Path.GetFileName(dir);
        try
        {
            if (tilesetSprites.Contains(name))
                continue;

            JsonElement yy = ReadYY(Path.Combine(dir, name + ".yy"));
            int width = yy.GetProperty("width").GetInt32();
            int height = yy.GetProperty("height").GetInt32();

            if (!dataSprites.TryGetValue(name, out UndertaleSprite sprite))
            {
                missing.Add($"sprite {name}");
                continue;
            }

            int frameCount = Names(yy, "frames").Count;
            if (frameCount != sprite.Textures.Count)
                warnings.Add($"sprite {name}: project has {frameCount} frames, game has {sprite.Textures.Count}");

            SaveSpriteFrames(dir, yy, i =>
            {
                UndertaleTexturePageItem tex = i < sprite.Textures.Count ? sprite.Textures[i]?.Texture : null;
                if (tex is null)
                    return Blank(width, height);
                return FitTo(worker.GetTextureFor(tex, $"{name} (frame {i})", true), width, height);
            });
        }
        catch (Exception e)
        {
            warnings.Add($"sprite {name}: {e.Message}");
        }
        finally
        {
            IncrementProgressParallel();
        }
    }

    foreach (string dir in tilesetDirs)
    {
        string name = Path.GetFileName(dir);
        try
        {
            JsonElement yy = ReadYY(Path.Combine(dir, name + ".yy"));
            IMagickImage<byte> tileImgSource;
            if (dataTilesets.TryGetValue(name, out UndertaleBackground bg) && bg.Texture is not null)
            {
                tileImgSource = worker.GetTextureFor(bg.Texture, name, true);
            }
            else
            {
                int columns = Math.Max(yy.GetProperty("out_columns").GetInt32(), 1);
                int count = Math.Max(yy.GetProperty("tile_count").GetInt32(), 1);
                int cellW = yy.GetProperty("tileWidth").GetInt32() + 2 * yy.GetProperty("out_tilehborder").GetInt32();
                int cellH = yy.GetProperty("tileHeight").GetInt32() + 2 * yy.GetProperty("out_tilevborder").GetInt32();
                tileImgSource = Blank(columns * cellW, (count + columns - 1) / columns * cellH);
                warnings.Add($"tileset {name}: the game doesn't have an image for this one so it got a blank one");
            }

            using IMagickImage<byte> tileImg = tileImgSource;
            TextureWorker.SaveImageToFile(tileImg, Path.Combine(dir, "output_tileset.png"));
            written++;

            string spriteName = yy.GetProperty("spriteId").GetProperty("name").GetString();
            string spriteDir = Path.Combine(projectDir, "sprites", spriteName);
            string spriteYY = Path.Combine(spriteDir, spriteName + ".yy");
            if (!File.Exists(spriteYY))
                continue;

            JsonElement syy = ReadYY(spriteYY);
            int width = syy.GetProperty("width").GetInt32();
            int height = syy.GetProperty("height").GetInt32();
            bool sameSize = (int)tileImg.Width == width && (int)tileImg.Height == height;

            SaveSpriteFrames(spriteDir, syy, i => sameSize ? (IMagickImage<byte>)tileImg.Clone() : Blank(width, height));
        }
        catch (Exception e)
        {
            warnings.Add($"tileset {name}: {e.Message}");
        }
        finally
        {
            IncrementProgressParallel();
        }
    }

    foreach (string dir in fontDirs)
    {
        string name = Path.GetFileName(dir);
        try
        {
            if (!dataFonts.TryGetValue(name, out UndertaleFont font) || font.Texture is null)
            {
                missing.Add($"font {name}");
                continue;
            }
            worker.ExportAsPNG(font.Texture, Path.Combine(dir, name + ".png"));
            written++;
        }
        catch (Exception e)
        {
            warnings.Add($"font {name}: {e.Message}");
        }
        finally
        {
            IncrementProgressParallel();
        }
    }
});

var audioGroups = new Dictionary<string, IList<UndertaleEmbeddedAudio>>(StringComparer.OrdinalIgnoreCase);

IList<UndertaleEmbeddedAudio> GetAudioGroup(UndertaleSound sound)
{
    string groupName = sound.AudioGroup?.Name?.Content ?? $"audiogroup{sound.GroupID}";
    if (audioGroups.TryGetValue(groupName, out var cached))
        return cached;

    var candidates = new List<string>();
    if (sound.AudioGroup?.Path?.Content is string customPath && customPath.Length > 0)
        candidates.Add(customPath);
    candidates.Add(groupName + ".dat");
    candidates.Add($"audiogroup{sound.GroupID}.dat");

    foreach (string rel in candidates)
    {
        string path = Path.Combine(gameDir, rel);
        if (!File.Exists(path))
            continue;
        using var stream = new FileStream(path, FileMode.Open, FileAccess.Read);
        UndertaleData groupData = UndertaleIO.Read(stream, (warning, _) => warnings.Add($"{rel}: {warning}"));
        audioGroups[groupName] = groupData.EmbeddedAudio;
        return groupData.EmbeddedAudio;
    }

    audioGroups[groupName] = null;
    return null;
}

byte[] GetSoundBytes(UndertaleSound sound)
{
    if (sound.AudioFile is not null)
        return sound.AudioFile.Data;

    if (sound.GroupID > Data.GetBuiltinSoundGroupID() && sound.AudioID >= 0)
    {
        var group = GetAudioGroup(sound);
        if (group is not null && sound.AudioID < group.Count)
            return group[sound.AudioID].Data;
    }

    if (sound.File?.Content is string ext && ext.Length > 0)
    {
        string external = ext.Contains('.') ? ext : ext + ".ogg";
        string path = Path.Combine(gameDir, external);
        if (File.Exists(path))
            return File.ReadAllBytes(path);
    }

    return null;
}

await Task.Run(() =>
{
    foreach (string dir in soundDirs)
    {
        string name = Path.GetFileName(dir);
        try
        {
            string yyPath = Path.Combine(dir, name + ".yy");
            JsonElement yy = ReadYY(yyPath);
            string soundFile = yy.TryGetProperty("soundFile", out JsonElement sf) ? sf.GetString() : name + ".wav";

            byte[] bytes = dataSounds.TryGetValue(name, out UndertaleSound sound) ? GetSoundBytes(sound) : null;
            if (bytes is null || bytes.Length == 0)
            {
                missing.Add($"sound {name}");
                continue;
            }

            bool isOgg = bytes.Length > 4 && bytes[0] == 'O' && bytes[1] == 'g' && bytes[2] == 'g' && bytes[3] == 'S';
            string wantedExt = isOgg ? ".ogg" : ".wav";
            if (!string.Equals(Path.GetExtension(soundFile), wantedExt, StringComparison.OrdinalIgnoreCase))
            {
                string newFile = Path.GetFileNameWithoutExtension(soundFile) + wantedExt;
                string text = File.ReadAllText(yyPath);
                File.WriteAllText(yyPath, text.Replace($"\"soundFile\":\"{soundFile}\"", $"\"soundFile\":\"{newFile}\""));
                warnings.Add($"sound {name}: game data is {wantedExt}, soundFile changed to {newFile}");
                soundFile = newFile;
            }

            File.WriteAllBytes(Path.Combine(dir, soundFile), bytes);
            written++;
        }
        catch (Exception e)
        {
            warnings.Add($"sound {name}: {e.Message}");
        }
        finally
        {
            IncrementProgressParallel();
        }
    }
});

await StopProgressBarUpdater();
HideProgressBar();

var report = new StringBuilder();
report.AppendLine($"wrote {written} files into {projectDir}");
if (missing.Count > 0)
{
    report.AppendLine();
    report.AppendLine($"couldn't find these in the game data ({missing.Count}):");
    foreach (string m in missing)
        report.AppendLine("  " + m);
}
if (warnings.Count > 0)
{
    report.AppendLine();
    report.AppendLine($"warnings ({warnings.Count}):");
    foreach (string w in warnings)
        report.AppendLine("  " + w);
}

File.WriteAllText(Path.Combine(projectDir, "gather_assets_log.txt"), report.ToString());

string summary = report.ToString();
if (summary.Length > 3000)
    summary = summary.Substring(0, 3000) + "\n...\n(the rest is in gather_assets_log.txt)";
ScriptMessage(summary);
