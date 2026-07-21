#!/data/data/com.termux/files/usr/bin/bash
#
# ytdl-termux - Simple YouTube downloader for Termux
# Uses yt-dlp under the hood.
#
# Usage:
#   ./download.sh
#
# The script will ask for:
#   1. The video/playlist URL
#   2. Whether you want Video or Audio
#   3. Quality/format
#
# Downloads are saved inside the "Downloads/ytdl-termux" folder
# on your phone storage (accessible from Gallery/Files app).

set -e

DOWNLOAD_DIR="$HOME/storage/downloads/ytdl-termux"
mkdir -p "$DOWNLOAD_DIR"

echo "========================================"
echo "   YouTube Downloader for Termux"
echo "========================================"
echo ""

# Check yt-dlp is installed
if ! command -v yt-dlp &> /dev/null; then
    echo "❌ yt-dlp is not installed."
    echo "Run: pkg install -y yt-dlp"
    exit 1
fi

read -p "🔗 Paste the YouTube video/playlist URL: " URL

if [ -z "$URL" ]; then
    echo "❌ No URL provided. Exiting."
    exit 1
fi

echo ""
echo "What do you want to download?"
echo "1) Video (MP4)"
echo "2) Audio only (MP3)"
read -p "Choose an option [1/2]: " CHOICE

echo ""

case "$CHOICE" in
    1)
        echo "Select video quality:"
        echo "1) Best available"
        echo "2) 1080p"
        echo "3) 720p"
        echo "4) 480p"
        echo "5) 360p"
        read -p "Choose [1-5]: " QUALITY

        case "$QUALITY" in
            1) FORMAT="bestvideo+bestaudio/best" ;;
            2) FORMAT="bestvideo[height<=1080]+bestaudio/best[height<=1080]" ;;
            3) FORMAT="bestvideo[height<=720]+bestaudio/best[height<=720]" ;;
            4) FORMAT="bestvideo[height<=480]+bestaudio/best[height<=480]" ;;
            5) FORMAT="bestvideo[height<=360]+bestaudio/best[height<=360]" ;;
            *) FORMAT="bestvideo+bestaudio/best" ;;
        esac

        yt-dlp -f "$FORMAT" \
            --merge-output-format mp4 \
            -o "$DOWNLOAD_DIR/%(title)s.%(ext)s" \
            "$URL"
        ;;
    2)
        yt-dlp -x --audio-format mp3 --audio-quality 0 \
            -o "$DOWNLOAD_DIR/%(title)s.%(ext)s" \
            "$URL"
        ;;
    *)
        echo "❌ Invalid choice. Exiting."
        exit 1
        ;;
esac

echo ""
echo "✅ Done! Files saved in: $DOWNLOAD_DIR"
