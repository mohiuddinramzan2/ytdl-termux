#!/data/data/com.termux/files/usr/bin/bash
#
# install.sh - Sets up everything needed to run ytdl-termux
#

echo "========================================"
echo "   Setting up ytdl-termux"
echo "========================================"
echo ""

echo "🔄 Updating package lists..."
pkg update -y

echo "📦 Installing required packages (python, ffmpeg, yt-dlp)..."
pkg install -y python ffmpeg yt-dlp

echo "📂 Setting up storage access..."
termux-setup-storage

echo "🔑 Making download.sh executable..."
chmod +x download.sh

echo ""
echo "✅ Setup complete!"
echo "Run the downloader with: ./download.sh"
