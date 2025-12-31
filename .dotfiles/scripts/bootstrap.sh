#!/bin/zsh

sudo pacman -Syu --needed --noconfirm

sudo pacman -S --needed \
    tmux telegram-desktop zsh zola nodejs npm nvim \
    git picom obsidian okular mpv konsole obs-studio \
    ttf-jetbrains-mono polybar pamixer feh xorg-xrandr \
    i3status brightnessctl numlockx python-virtualenv python-pynvim \
    luarocks rust neovim 
