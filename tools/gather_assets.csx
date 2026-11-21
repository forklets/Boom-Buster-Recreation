// fills this project back in with boom buster's art, sounds and included files from your copy of the game
// needs utmt 0.9+. open the game's data.win (with ag_bgm.dat next to it) and run this

using System;
using System.IO;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Collections.Generic;
using System.Collections.Concurrent;
using System.Text.RegularExpressions;
using ImageMagick;
using UndertaleModLib.Util;

EnsureDataLoaded();

string version = Data.GeneralInfo.DisplayName.Content;
if (!version.StartsWith("BOOM! Buster") || !version.EndsWith("1.0.8.3"))
{
    ScriptError($"this project is synced to boom buster 1.0.8.3 but that data.win is \"{version}\". update the game on steam first");
    return;
}

string proj = FindProject();
if (proj == null)
    return;

string game = Path.GetDirectoryName(FilePath);
var missing = new ConcurrentBag<string>();
int written = 0;
var started = DateTime.Now;

var steps = new (string label, Action run)[]
{
    ("sprites", Sprites),
    ("tilesets", Tilesets),
    ("fonts", Fonts),
    ("sounds", Sounds),
    ("included files", IncludedFiles),
};

SetProgressBar(null, steps[0].label, 0, steps.Length);
StartProgressBarUpdater();
await Task.Run(() =>
{
    foreach (var step in steps)
    {
        UpdateProgressStatus(step.label);
        step.run();
        IncrementProgress();
    }
});
await StopProgressBarUpdater();
HideProgressBar();

string report = $"{written} files in {(DateTime.Now - started).TotalSeconds:0}s, you can open BusterBeta.yyp now";
if (!missing.IsEmpty)
    report += "\n\nthese weren't in the data.win:\n" + string.Join("\n", missing.OrderBy(m => m));
ScriptMessage(report);


// the script sits in tools/, so try the folder above it before asking
string FindProject()
{
    try
    {
        string guess = Path.GetFullPath(Path.Combine(Path.GetDirectoryName(ScriptPath), ".."));
        if (File.Exists(Path.Combine(guess, "BusterBeta.yyp")))
            return guess;
    }
    catch { }

    ScriptMessage("couldn't tell where the project is, pick the folder with BusterBeta.yyp in it");
    string picked = PromptChooseDirectory();
    if (picked != null && !File.Exists(Path.Combine(picked, "BusterBeta.yyp")))
    {
        ScriptError("no BusterBeta.yyp in that folder");
        return null;
    }
    return picked;
}

string[] Assets(string kind) => Directory.GetDirectories(Path.Combine(proj, kind));
string Meta(string dir) => File.ReadAllText(Path.Combine(dir, Path.GetFileName(dir) + ".yy"));
int Int(string meta, string key) => int.Parse(Regex.Match(meta, $"\"{key}\":(\\d+)").Groups[1].Value);
string Link(string meta, string key) => Regex.Match(meta, $"\"{key}\":\\{{\\s*\"name\":\"([^\"]+)\"").Groups[1].Value;
string[] Names(string meta, string kind) => Regex.Matches(meta, $"\"\\${kind}\":\"[^\"]*\",\"%Name\":\"([^\"]+)\"").Select(m => m.Groups[1].Value).ToArray();

void Empty(string path, int w, int h)
{
    using var img = new MagickImage(MagickColors.Transparent, (uint)Math.Max(w, 1), (uint)Math.Max(h, 1));
    TextureWorker.SaveImageToFile(img, path);
}

// gamemaker wants each frame twice, once on its own and once per image layer
string[] Targets(string dir, string meta, string frame)
{
    var list = new List<string> { Path.Combine(dir, frame + ".png") };
    foreach (string layer in Names(meta, "GMImageLayer"))
    {
        Directory.CreateDirectory(Path.Combine(dir, "layers", frame));
        list.Add(Path.Combine(dir, "layers", frame, layer + ".png"));
    }
    return list.ToArray();
}

void Spread(string[] targets)
{
    for (int i = 1; i < targets.Length; i++)
        File.Copy(targets[0], targets[i], true);
    Interlocked.Add(ref written, targets.Length);
}

void Sprites()
{
    // sprites behind tilesets don't exist in data.win, Tilesets() handles those
    var skip = Assets("tilesets").Select(d => Link(Meta(d), "spriteId")).ToHashSet();
    var work = new List<(UndertaleTexturePageItem tex, int w, int h, string[] targets)>();

    foreach (string dir in Assets("sprites").Where(d => !skip.Contains(Path.GetFileName(d))))
    {
        var sprite = Data.Sprites.ByName(Path.GetFileName(dir), true);
        if (sprite == null)
        {
            missing.Add(Path.GetFileName(dir));
            continue;
        }
        string meta = Meta(dir);
        string[] frames = Names(meta, "GMSpriteFrame");
        for (int i = 0; i < frames.Length; i++)
            work.Add((i < sprite.Textures.Count ? sprite.Textures[i]?.Texture : null, Int(meta, "width"), Int(meta, "height"), Targets(dir, meta, frames[i])));
    }

    // frames on the same texture page share a worker so that page is only decoded once
    Parallel.ForEach(work.GroupBy(w => w.tex?.TexturePage), new ParallelOptions { MaxDegreeOfParallelism = Math.Max(1, Environment.ProcessorCount / 2) }, page =>
    {
        using var worker = new TextureWorker();
        foreach (var w in page)
        {
            if (w.tex == null)
                Empty(w.targets[0], w.w, w.h);
            else
                worker.ExportAsPNG(w.tex, w.targets[0], null, true);
            Spread(w.targets);
        }
    });
}

void Tilesets()
{
    using var worker = new TextureWorker();
    foreach (string dir in Assets("tilesets"))
    {
        string meta = Meta(dir), image = Path.Combine(dir, "output_tileset.png");
        var tex = Data.Backgrounds.ByName(Path.GetFileName(dir), true)?.Texture;

        if (tex != null)
            worker.ExportAsPNG(tex, image, null, true);
        else
        {
            int cols = Int(meta, "out_columns"), rows = (Int(meta, "tile_count") + cols - 1) / cols;
            Empty(image, cols * (Int(meta, "tileWidth") + 2 * Int(meta, "out_tilehborder")), rows * (Int(meta, "tileHeight") + 2 * Int(meta, "out_tilevborder")));
        }
        written++;

        // and the sprite it's built from is the same picture
        string spriteDir = Path.Combine(proj, "sprites", Link(meta, "spriteId")), spriteMeta = Meta(spriteDir);
        foreach (string frame in Names(spriteMeta, "GMSpriteFrame"))
        {
            string[] targets = Targets(spriteDir, spriteMeta, frame);
            if (tex != null)
                File.Copy(image, targets[0], true);
            else
                Empty(targets[0], Int(spriteMeta, "width"), Int(spriteMeta, "height"));
            Spread(targets);
        }
    }
}

void Fonts()
{
    using var worker = new TextureWorker();
    foreach (string dir in Assets("fonts"))
    {
        string name = Path.GetFileName(dir);
        var tex = Data.Fonts.ByName(name, true)?.Texture;
        if (tex == null)
        {
            missing.Add(name);
            continue;
        }
        worker.ExportAsPNG(tex, Path.Combine(dir, name + ".png"));
        written++;
    }
}

void Sounds()
{
    // most sounds are inside data.win, the music is in ag_bgm.dat, anything else is loose in the game folder
    var groupCache = new Dictionary<string, IList<UndertaleEmbeddedAudio>>();
    IList<UndertaleEmbeddedAudio> GroupOf(UndertaleSound s)
    {
        string name = s.AudioGroup?.Name?.Content ?? $"audiogroup{s.GroupID}";
        if (!groupCache.ContainsKey(name))
        {
            string file = new[] { s.AudioGroup?.Path?.Content, name + ".dat", $"audiogroup{s.GroupID}.dat" }
                .Where(f => !string.IsNullOrEmpty(f)).Select(f => Path.Combine(game, f)).FirstOrDefault(File.Exists);
            using var stream = file == null ? null : File.OpenRead(file);
            groupCache[name] = stream == null ? null : UndertaleIO.Read(stream, (w, _) => { }).EmbeddedAudio;
        }
        return groupCache[name];
    }

    foreach (string dir in Assets("sounds"))
    {
        string name = Path.GetFileName(dir);
        string file = Regex.Match(Meta(dir), "\"soundFile\":\"([^\"]+)\"").Groups[1].Value;
        var sound = Data.Sounds.ByName(name, true);

        byte[] data = sound?.AudioFile?.Data;
        if (data == null && sound?.AudioID >= 0)
            data = GroupOf(sound)?.ElementAtOrDefault(sound.AudioID)?.Data;
        if (data == null && sound?.File?.Content is string loose)
        {
            string path = Path.Combine(game, Path.HasExtension(loose) ? loose : loose + ".ogg");
            if (File.Exists(path))
                data = File.ReadAllBytes(path);
        }

        if (data == null || file == "")
        {
            missing.Add(name);
            continue;
        }
        File.WriteAllBytes(Path.Combine(dir, file), data);
        written++;
    }
}

void IncludedFiles()
{
    // refresh whatever the project already has under datafiles from the copy in the game folder.
    // line endings are ignored so git doesn't see every file as changed
    string datafiles = Path.Combine(proj, "datafiles");
    if (!Directory.Exists(datafiles))
        return;

    foreach (string file in Directory.GetFiles(datafiles, "*", SearchOption.AllDirectories))
    {
        string fromGame = Path.Combine(game, Path.GetRelativePath(datafiles, file));
        if (!File.Exists(fromGame))
            continue;

        byte[] theirs = File.ReadAllBytes(fromGame);
        if (theirs.Where(b => b != '\r').SequenceEqual(File.ReadAllBytes(file).Where(b => b != '\r')))
            continue;
        File.WriteAllBytes(file, theirs.Where(b => b != '\r').ToArray());
        written++;
    }
}
