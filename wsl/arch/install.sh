#!/bin/bash

script_path=$(readlink -f ${BASH_SOURCE[0]})
script_dir=$(dirname "$script_path")

if ! grep -q "^\[archlinuxcn\]" /etc/pacman.conf || ! grep -q "^Server = https://mirrors.ustc.edu.cn/archlinuxcn/\$arch" /etc/pacman.conf; then
    echo "[archlinuxcn]" | sudo tee -a /etc/pacman.conf
    echo "Server = https://mirrors.ustc.edu.cn/archlinuxcn/\$arch" | sudo tee -a /etc/pacman.conf
fi

sudo cp "$script_dir/wsl.conf" /etc/wsl.conf
sudo pacman-key --init
sudo pacman-key --populate
sudo pacman -Sy archlinux-keyring
sudo pacman -Sy archlinuxcn-keyring
sudo pacman -Su
sudo pacman-key --lsign-key "farseerfc@archlinux.org"

read -p "Do you want to install the software pacages? (Y/N): " choice
choice=$(echo "$choice" | tr '[:lower:]' '[:upper:]')
if [[ $choice == "Y" ]]; then
    sudo pacman -S --needed - < "$script_dir/packages.txt"
fi

if type zsh >/dev/null 2>&1; then
    chsh -s /usr/bin/zsh
    sudo ln -s "$script_dir/zshrc" ~/.zshrc
    sudo ln -s "$script_dir/shell_title" ~/shell_title.zsh
    sudo ln -s "$script_dir/p10k.zsh" ~/.p10k.zsh
fi

cp "$script_dir/../clang-format" ~/.clang-format
vim_sh="$script_dir/../../vim/install.sh"
source $vim_sh
git_sh="$script_dir/../../git/install.sh"
source $git_sh
