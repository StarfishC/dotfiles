#!/bin/bash

if ! type vim >/dev/null 2>&1;then
    echo "Vim is not installed." >&2
    exit 1
fi

script_path=$(readlink -f ${BASH_SOURCE[0]})
script_dir=$(dirname "$script_path")

mkdir -p ~/.vim

echo "Please choose: "
echo "1. Copy the vim configuration"
echo "2. Create a symbolic link for the vim configuration"

read choice

function VimConfig() {
    local command=""
    command="$1 $script_dir/vimrc ~/.vim/vimrc"
    eval "$command"
    command="$1 $script_dir/tasks.json ~/.vim/tasks.json"
    eval "$command"
    command="$1 $script_dir/coc-settings.json ~/.vim/coc-settings.json"
    eval "$command"
    if [ "$1" = "cp" ]; then
        command="$1 -r $script_dir/syntax ~/.vim/syntax"
    else
        command="$1 $script_dir/syntax ~/.vim/syntax"
    fi
    eval "$command"
}

if [ "$choice" = "1" ]; then
    VimConfig "cp"
elif [ "$choice" = "2" ]; then
    VimConfig "ln -sf"
else
    exit 1
fi

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim -c 'PlugInstall | qa!'
