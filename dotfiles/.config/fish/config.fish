#!/usr/bin/env fish

# Disable the greeting
set fish_greeting

fish_config theme choose "Dracula Official"

set -gx EDITOR nvim
set -gx LANG en_AU.UTF-8

if status --is-interactive;
  starship init fish | source
end
direnv hook fish | source
rbenv init - fish | source
pyenv init - | source
zoxide init fish | source

function fish_user_key_bindings
  # Make Ctrl-z return last suspended job to the foreground
  bind \cz 'fg 2>/dev/null; commandline -f repaint'
  bind \ct 't'
end

abbr -a -- g git
abbr -a -- pip python -m pip
abbr -a -- pt pytest
abbr -a -- v $EDITOR

function vim --wraps=nvim --description 'alias vim nvim'
  nvim $argv
end
