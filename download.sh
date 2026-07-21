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

# ---------- Colors ----------
RED='\033[1;31m'
WHITE='\033[1;37m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
BOLD='\033[1m'
RESET='\033[0m'

DOWNLOAD_DIR="$HOME/storage/downloads/ytdl-termux"
mkdir -p "$DOWNLOAD_DIR"

clear

# ---------- Banner (YouTube-style logo) ----------
echo -e "${RED}"
echo "   ██╗   ██╗ ██████╗ ██╗   ██╗████████╗██╗   ██╗██████╗ ███████╗"
echo "   ╚██╗ ██╔╝██╔═══██╗██║   ██║╚══██╔══╝██║   ██║██╔══██╗██╔════╝"
echo "    ╚████╔╝ ██║   ██║██║   ██║   ██║   ██║   ██║██████╔╝█████╗  "
echo "     ╚██╔╝  ██║   ██║██║   ██║   ██║   ██║   ██║██╔══██╗██╔══╝  "
echo "      ██║   ╚██████╔╝╚██████╔╝   ██║   ╚██████╔╝██████╔╝███████╗"
echo "      ╚═╝    ╚═════╝  ╚═════╝    ╚═╝    ╚═════╝ ╚═════╝ ╚══════╝"
echo -e "${RESET}"
echo -e "${WHITE}${BOLD}              ▶  YOUTUBE DOWNLOADER FOR TERMUX  ▶${RESET}"
echo -e "${CYAN}       ─────────────────────────────────────────────────${RESET}"
echo -e "${YELLOW}                Created by ${BOLD}Mohiuddin Ramzan${RESET}"
echo -e "${CYAN}       ─────────────────────────────────────────────────${RESET}"
echo ""

# Check yt-dlp is installed
if ! command -v yt-dlp &> /dev/null; then
    echo -e "${RED}❌ yt-dlp is not installed.${RESET}"
    echo -e "   Run: ${GREEN}pkg install -y yt-dlp${RESET}"
    exit 1
fi

echo -e "${GREEN}🔗 Paste the YouTube video/playlist URL:${RESET}"
read -p "   > " URL

if [ -z "$URL" ]; then
    echo -e "${RED}❌ No URL provided. Exiting.${RESET}"
    exit 1
fi

echo ""
echo -e "${WHITE}${BOLD}What do you want to download?${RESET}"
echo -e "   ${CYAN}1)${RESET} Video (MP4)"
echo -e "   ${CYAN}2)${RESET} Audio only (MP3)"
read -p "   Choose an option [1/2]: " CHOICE

echo ""

case "$CHOICE" in
    1)
        echo -e "${WHITE}${BOLD}Select video quality:${RESET}"
        echo -e "   ${CYAN}1)${RESET} Best available"
        echo -e "   ${CYAN}2)${RESET} 1080p"
        echo -e "   ${CYAN}3)${RESET} 720p"
        echo -e "   ${CYAN}4)${RESET} 480p"
        echo -e "   ${CYAN}5)${RESET} 360p"
        read -p "   Choose [1-5]: " QUALITY

        case "$QUALITY" in
            1) FORMAT="bestvideo+bestaudio/best" ;;
            2) FORMAT="bestvideo[height<=1080]+bestaudio/best[height<=1080]" ;;
            3) FORMAT="bestvideo[height<=720]+bestaudio/best[height<=720]" ;;
            4) FORMAT="bestvideo[height<=480]+bestaudio/best[height<=480]" ;;
            5) FORMAT="bestvideo[height<=360]+bestaudio/best[height<=360]" ;;
            *) FORMAT="bestvideo+bestaudio/best" ;;
        esac

        echo ""
        echo -e "${YELLOW}⏳ Downloading video, please wait...${RESET}"
        echo ""

        yt-dlp -f "$FORMAT" \
            --merge-output-format mp4 \
            -o "$DOWNLOAD_DIR/%(title)s.%(ext)s" \
            "$URL"
        ;;
    2)
        echo ""
        echo -e "${YELLOW}⏳ Downloading audio, please wait...${RESET}"
        echo ""

        yt-dlp -x --audio-format mp3 --audio-quality 0 \
            -o "$DOWNLOAD_DIR/%(title)s.%(ext)s" \
            "$URL"
        ;;
    *)
        echo -e "${RED}❌ Invalid choice. Exiting.${RESET}"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}${BOLD}✅ Done! Files saved in:${RESET} $DOWNLOAD_DIR"
echo ""
echo -e "${CYAN}       ─────────────────────────────────────────────────${RESET}"
echo -e "${YELLOW}          Thanks for using ytdl-termux — ${BOLD}Mohiuddin Ramzan${RESET}"
echo -e "${CYAN}       ─────────────────────────────────────────────────${RESET}"
