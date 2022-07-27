#!/usr/bin/env fish
set fish_greeting

set -gx EDITOR vim
set -gx LANG en_AU.UTF-8

# Init pyenv
status is-login; and pyenv init --path | source
pyenv init --path | source

# Initialize direnv
direnv hook fish | source

# Initialize starship
starship init fish | source
