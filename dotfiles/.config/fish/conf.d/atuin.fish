
source $HOME/.atuin/bin/env.fish
if status --is-interactive;
  atuin init fish | source
end
