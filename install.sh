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
      cp -r "conf/$dir/"* "$HOME/.config/$dir/"
    else
      echo "  ! $dir not found, skipping"
    fi
  done
  cp "./conf/tmux.conf" ~/.tmux.conf
}

install_packages() {
  echo "[*] Installing required packages via pacman"
  sudo pacman -Syu --noconfirm "${PACKAGES[@]}"
}

install_nvim() {
    echo "[*] Installing nvim"
    if command -v pacman &>/dev/null; then
        echo "[*] Installing required packages via pacman"
        sudo pacman -Syu --noconfirm "neovim npm zig"
    elif command -v apt &>/dev/null; then
        echo "[*] Installing required packages via apt"
        sudo apt update
        sudo apt install -y "zig neovim npm"
    else
        echo "[!] Neither pacman nor apt found. Please install dependencies manually."
        exit 1
    fi
}

# Main
if [ "$1" = "copy" ]; then
  copy_configs
elif [ "$1" = "nvim" ]; then
    install_nvim
else
  install_packages
  copy_configs
fi

echo "[✔] Done."

