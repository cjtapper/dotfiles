#!/usr/bin/env fish

# Disable the greeting
set fish_greeting

set -gx EDITOR nvim
set -gx LANG en_AU.UTF-8
set -gx STARSHIP_LOG error

if status --is-interactive;
    starship init fish | source
end
direnv hook fish | source
zoxide init fish | source

function fish_user_key_bindings
    # Make Ctrl-z return last suspended job to the foreground
    bind \cz 'fg 2>/dev/null; commandline -f repaint'
end

abbr --add -- g git
abbr --add -- gaa git add --all
abbr --add -- gau git add --update
abbr --add --set-cursor -- gcm git commit --message \"%\"
abbr --add -- gds git diff --staged
abbr --add --set-cursor -- gsc git switch --create \"cjtapper/%\"
abbr --add -- gr. git restore .
abbr --add -- gsm git switch-main
abbr --add -- gsr git switch-recent
abbr --add -- gs- git switch -

abbr --add -- pip python -m pip
abbr --add -- pt pytest
abbr --add -- v $EDITOR
abbr --add -- tf terraform
abbr --add -- mk make

alias ls eza
alias fd fdfind
alias cat batcat
alias bat batcat
alias vim nvim

# Load machine specific config
source (dirname (status -f))/(hostname).config.fish 2>/dev/null

# Shift venv to the front of the path (if it was already activated). This is
# helpful in e.g. neovim, which spawns subshells.
if test -n $VIRTUAL_ENV
  while set venv_index (contains -i -- $VIRTUAL_ENV/bin $PATH)
    set -eg PATH[$venv_index]
  end;
  set -e venv_index

  set -gx PATH $VIRTUAL_ENV/bin $PATH
end

# uv
uv generate-shell-completion fish | source
fish_add_path "/home/cjtapper/.local/bin"

/home/cjtapper/.local/bin/mise activate fish | source
