#!/usr/bin/env fish

# Disable the greeting
set fish_greeting

fish_config theme choose "Dracula Official"

set -gx EDITOR nvim
set -gx LANG en_AU.UTF-8
set -gx STARSHIP_LOG error

# Dracula theme for FZF
set -gx FZF_DEFAULT_OPTS "--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"


if status --is-interactive;
    starship init fish | source
end
direnv hook fish | source
zoxide init fish | source

function fish_user_key_bindings
    # Make Ctrl-z return last suspended job to the foreground
    bind \cz 'fg 2>/dev/null; commandline -f repaint'
    # Start tmux session
    bind \ct 't;commandline -f repaint'
end

abbr -a -- g git
abbr -a -- pip python -m pip
abbr -a -- pt pytest
abbr -a -- v $EDITOR
abbr -a -- tf terraform
abbr -a -- mk make

function vim --wraps=nvim --description 'alias vim nvim'
    nvim $argv
end

# Load machine specific config
source (dirname (status -f))/(hostname).config.fish 2>/dev/null
