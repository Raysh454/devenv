#!/bin/bash

# Set wallpaper directories
WALLPAPER_DIR="$HOME/.config/wallpapers"
CURRENT_WP_FILE="$WALLPAPER_DIR/current"
BLURRED_WP="$WALLPAPER_DIR/current_blurred"
BLUR="50x30"

# Get current wallpaper path from swww
current_wallpaper=$(swww query | grep -oP 'image: \K.*')

# Select a random wallpaper that is not the current one
wallpaper=$(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' \) ! -iname '*blurred*' \
    ! -path "$current_wallpaper" | shuf -n 1)

# Fallback in case all images are excluded
if [ -z "$wallpaper" ]; then
    echo ":: No new wallpaper found. Using current wallpaper."
    wallpaper="$current_wallpaper"
fi

# Set colors using pywal
wal -b "#24273A" -q -i "$wallpaper"

# Source pywal colors
source "$HOME/.cache/wal/colors.sh"

# Set wallpaper with swww
swww img "$wallpaper" --transition-type=grow --transition-pos top-right

# Launch waybar if launcher script exists
[ -x "$HOME/.config/waybar/launch.sh" ] && "$HOME/.config/waybar/launch.sh"

# Update cava symlink
ln -sf "$HOME/.cache/wal/cava-colors" "$HOME/.config/cava/config"

# Generate blurred version (for lock screen, wlogout, etc.)
magick "$wallpaper" -resize 1920x1080\! "$wallpaper"
echo ":: Resized"

if [ "$BLUR" != "0x0" ]; then
    magick "$wallpaper" -blur "$BLUR" "$BLURRED_WP"
    echo ":: Blurred"
fi

# Save current wallpaper path
echo "$wallpaper" > "$CURRENT_WP_FILE"

