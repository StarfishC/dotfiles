#!/bin/bash

if ! type git >/dev/null 2>&1;then
    echo "Git is not installed." >&2
    exit 1
fi

echo "Please enter your git email: "
read email
echo "Please enter your git name: "
read name

git config --global user.email "$email"
git config --global user.name "$name"
git config --global core.editor "vim"

./ssh.sh $email
