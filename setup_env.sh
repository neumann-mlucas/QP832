#!/bin/bash

# setup vim config
cp vimrc_copy.vim ~/.vimrc
mkdir -p ~/.vim/autoload
cp plug.vim ~/.vim/autoload

# Restart keyboard config
setxkbmap -layout br

# H J K L keys repeat
xset -r 43
xset -r 44
xset -r 45
xset -r 46
xset r rate 180 50

# Change Caps <-> Esc
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keycode 66 = Escape"
