#!/data/data/com.termux/files/usr/bin/bash

# Create download directory
DOWNLOAD_DIR="/sdcard/PANGO-Downloads"
mkdir -p "$DOWNLOAD_DIR"

# Interface
clear
echo -e "\e[1;32m"
figlet "PANGO-DL" | lolcat
echo -e "\e[1;34mPowered by Pango404 "
echo -e "\e[1;33mSave path: $DOWNLOAD_DIR\n"

# Get URL
read -p "Enter YouTube video or playlist URL: " url

# Choose quality
echo -e "\nSelect download quality:"
echo "1) Best quality"
echo "2) 720p video"
echo "3) Audio only (MP3)"
read -p "Enter choice (1/2/3): " choice

# Ask for subtitles
read -p "Download subtitles if available? (y/n): " subs

# Start download
echo -e "\nStarting download...\n" | lolcat

case $choice in
  1)
    yt-dlp -o "$DOWNLOAD_DIR/%(title)s.%(ext)s" \
           $( [ "$subs" == "y" ] && echo "--write-subs --embed-subs --sub-lang en" ) \
           "$url"
    ;;
  2)
    yt-dlp -f "best[height<=720]" \
           -o "$DOWNLOAD_DIR/%(title)s.%(ext)s" \
           $( [ "$subs" == "y" ] && echo "--write-subs --embed-subs --sub-lang en" ) \
           "$url"
    ;;
  3)
    yt-dlp -x --audio-format mp3 \
           -o "$DOWNLOAD_DIR/%(title)s.%(ext)s" \
           "$url"
    ;;
  *)
    echo "Invalid choice!"
    exit 1
    ;;
esac

echo -e "\n\e[1;32mDownload finished!" | lolcat
echo -e "Saved to: $DOWNLOAD_DIR\n" 
