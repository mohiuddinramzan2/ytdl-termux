# ytdl-termux 📱🎬

A simple, lightweight YouTube video/audio downloader built for **Termux** on Android. Powered by [`yt-dlp`](https://github.com/yt-dlp/yt-dlp), the actively maintained successor to `youtube-dl`.

Download YouTube videos as **MP4** or extract audio as **MP3**, directly on your phone — no PC required.

---

## ✨ Features

- ✅ Download YouTube videos (single video or playlist)
- ✅ Choose video quality: Best, 1080p, 720p, 480p, 360p
- ✅ Extract audio only, saved as MP3
- ✅ Downloads saved directly to your phone's `Downloads` folder (visible in Gallery/Files app)
- ✅ Simple interactive menu — no need to remember commands
- ✅ Works fully offline once dependencies are installed (no server/API needed)

---

## 📋 Requirements

- Android phone
- [Termux](https://f-droid.org/en/packages/com.termux/) installed **from F-Droid** (⚠️ the Play Store version is outdated and no longer maintained — always use F-Droid)

---

## 🚀 Installation

Open Termux and run the following commands one by one:

### 1. Update Termux packages
```bash
pkg update -y && pkg upgrade -y
```

### 2. Install Git (to clone this repository)
```bash
pkg install -y git
```

### 3. Clone this repository
```bash
git clone https://github.com/mohiuddinramzan2/ytdl-termux.git
cd ytdl-termux
```

### 4. Run the setup script
This installs Python, ffmpeg, and yt-dlp, and gives Termux access to your phone storage.
```bash
bash install.sh
```

> When prompted by `termux-setup-storage`, tap **Allow** so Termux can save files to your Downloads folder.

---

## ▶️ Usage

Run the downloader script:
```bash
./download.sh
```

You'll be asked to:
1. **Paste the YouTube URL** (video or playlist link)
2. **Choose Video or Audio**
   - Video → choose quality (Best / 1080p / 720p / 480p / 360p)
   - Audio → automatically saved as MP3 (best quality)
3. Wait for the download to finish ✅

Downloaded files are saved in:
```
/storage/emulated/0/Download/ytdl-termux/
```
You can access them from your phone's **Files app** or **Gallery** (for videos).

---

## 🛠️ Manual Commands (without the script)

If you prefer running `yt-dlp` directly instead of the interactive script:

**Download best quality video:**
```bash
yt-dlp -f "bestvideo+bestaudio/best" --merge-output-format mp4 "VIDEO_URL"
```

**Download a specific resolution (e.g. 720p):**
```bash
yt-dlp -f "bestvideo[height<=720]+bestaudio/best[height<=720]" --merge-output-format mp4 "VIDEO_URL"
```

**Download audio only as MP3:**
```bash
yt-dlp -x --audio-format mp3 --audio-quality 0 "VIDEO_URL"
```

**Download an entire playlist:**
```bash
yt-dlp -f "bestvideo+bestaudio/best" --merge-output-format mp4 -o "%(playlist_index)s-%(title)s.%(ext)s" "PLAYLIST_URL"
```

**Download subtitles along with video:**
```bash
yt-dlp --write-subs --sub-lang en -f "bestvideo+bestaudio/best" "VIDEO_URL"
```

---

## 🔄 Updating yt-dlp

YouTube frequently changes its site, which can break downloads. Keep `yt-dlp` updated:
```bash
pip install -U yt-dlp
```
or
```bash
pkg upgrade yt-dlp
```

---

## ❗ Troubleshooting

| Problem | Solution |
|---|---|
| `yt-dlp: command not found` | Run `bash install.sh` again, or `pkg install -y yt-dlp` |
| Download fails with "Unable to extract" | Update yt-dlp: `pip install -U yt-dlp` |
| Files not visible in Gallery/Files app | Run `termux-setup-storage` and allow permission |
| ffmpeg errors during merge | Run `pkg install -y ffmpeg` |
| Slow download speed | Try a different network, or lower the video quality |

---

## ⚠️ Disclaimer

This tool is intended for downloading videos you have the right to download (your own content, Creative Commons content, or content where downloading is permitted). Downloading copyrighted content without permission may violate YouTube's Terms of Service and copyright laws in your country. Use responsibly.

---

## 📄 License

This project is licensed under the MIT License — feel free to use, modify, and share.
