#!/bin/bash

if [ -z "$1" ]; then
    echo "Please enter your git email"
    exit 1
fi

ssh-keygen -t rsa -C $1

eval "$(ssh-agent -s)"

ssh-add ~/.ssh/id_rsa

echo "Your pulic rsa: "
cat ~/.ssh/id_rsa.pub

