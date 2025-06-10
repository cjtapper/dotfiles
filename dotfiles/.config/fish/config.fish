#!/usr/bin/env fish

set fish_greeting # Disable the greeting

fish_config theme choose ansi

set -gx EDITOR nvim
set -gx LANG en_AU.UTF-8
set -gx STARSHIP_LOG error

fish_add_path "/home/cjtapper/.local/bin"
fish_add_path "/home/cjtapper/.nix-profile/bin"

if status --is-interactive;
    starship init fish | source
end
direnv hook fish | source
zoxide init fish | source
mise activate fish | source

function fish_user_key_bindings
    # Make Ctrl-z return last suspended job to the foreground
    bind \cz 'fg 2>/dev/null; commandline -f repaint'
end

function fix_nvim_arg
  # Transforms strings like "hello.py:3" to "+3 hello.py"
  string match --quiet --regex ^nvim -- (commandline --current-job); or return 1

  set -l regex '([^\s:]+(?:\/[^\s:]+)*):(\d+)$'
  set -l matches (string match --regex -- $regex -- $argv)

  if test (count $matches) -gt 0
    set filename $matches[2]
    set line $matches[3]

    echo "+$line $filename"
  else
    return 1
  end
end
abbr -a nvim_line_num --position anywhere --regex '.+\.py:(\d+)' --function fix_nvim_arg

abbr --add -- g git
abbr --add -- gaa git add --all
abbr --add -- gau git add --update
abbr --add --set-cursor -- gcm git commit --message \"%\"
abbr --add -- gca git commit --amend --noedit
abbr --add -- gds git diff --staged
abbr --add --set-cursor -- gsc git switch --create \"cjtapper/%\"
abbr --add -- gr. git restore .
abbr --add -- gsm git switch-main
abbr --add -- gsr git switch-recent
abbr --add -- gs- git switch -

abbr --add -- mk make
abbr --add -- pip python -m pip
abbr --add -- pt pytest
abbr --add -- ptlf pytest --lf
abbr --add -- tf terraform
abbr --add -- v $EDITOR

alias bat batcat
alias cat batcat
alias fd fdfind
alias ls "eza --group-directories-first --icons"
alias vim nvim

alias scw "zellij attach scw"

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

# Custom path for fisher plugins
set fisher_path $__fish_user_data_dir/fisher

set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..]
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..]

for file in $fisher_path/conf.d/*.fish
    source $file
end
