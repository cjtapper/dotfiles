#!/usr/bin/env fish

# Disable the greeting
set fish_greeting

fish_config theme choose "Dracula"

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

abbr --add -- g git
abbr --add -- gaa git add --all
abbr --add --set-cursor -- gcm git commit --message \"%\"
abbr --add -- gds git diff --staged
abbr --add --set-cursor -- gsc git switch --create \"cjtapper/%\"
abbr --add -- gr. git restore .
abbr --add -- gsm "git switch (git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')"
abbr --add -- gsr git switch-recent
abbr --add -- gs- git switch -

abbr --add -- pip python -m pip
abbr --add -- pt pytest
abbr --add -- v $EDITOR
abbr --add -- tf terraform
abbr --add -- mk make

function vim --wraps=nvim --description 'alias vim nvim'
    nvim $argv
end

# Load machine specific config
source (dirname (status -f))/(hostname).config.fish 2>/dev/null

# Created by `pipx` on 2023-08-04 07:01:10
set PATH $PATH /Users/cjtapper/.local/bin

# Shift venv to the front of the path (if it was already activated). This is
# helpful in e.g. neovim, which spawns subshells.
if test -n $VIRTUAL_ENV
  while set venv_index (contains -i -- $VIRTUAL_ENV/bin $PATH)
  set -eg PATH[$venv_index]; end; set -e venv_index
  set -gx PATH $VIRTUAL_ENV/bin $PATH
end
