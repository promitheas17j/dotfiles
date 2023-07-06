#!/bin/sh

cd ~/.local/share/chezmoi
git pull
chezmoi update -v
