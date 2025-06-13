#!/bin/bash

# List of config directories to copy
CONFIG_DIRS=(alacritty hypr nvim wal wallpapers waybar wofi)

# List of required packages
PACKAGES=(
  hyprland
  waybar
  python-pywal
  wofi
  cliphist
  wl-clipboard
  swww
  network-manager-applet
  dunst
  flameshot
  scrot
  zig
  nvim
  npm
)

copy_configs() {
  echo "[*] Copying config directories to ~/.config"
  for dir in "${CONFIG_DIRS[@]}"; do
    if [ -d "$dir" ]; then
      echo "  - $dir"
      mkdir -p "$HOME/.config/$dir"
      cp -r "$dir/"* "$HOME/.config/$dir/"
    else
      echo "  ! $dir not found, skipping"
    fi
  done
}

install_packages() {
  echo "[*] Installing required packages via pacman"
  sudo pacman -Syu --noconfirm "${PACKAGES[@]}"
}

# Main
if [ "$1" = "copy" ]; then
  copy_configs
else
  install_packages
  copy_configs
fi

echo "[✔] Done."

