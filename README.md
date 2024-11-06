# cjtapper's dotfiles
My dotfiles for terminal-based development (mostly Python) and computer fun
times.

Right now I'm running Linux Mint and just using the default Cinnamon window
manager, though I have used `i3` extensively in the past. Most, if not all, of
the configuration here should be platform agnostic.

## Dependencies
- [GNU Stow](https://www.gnu.org/software/stow/) to symlink the dotfiles and
scripts into the user's home directory
- See [Tools](#tools) section for everything else

## Setup
```
$ make install
```

## Tools
I haven't automated installation of these yet, but you get the idea.
- [`alacritty`](https://alacritty.org/) for my fast and simple terminal emulator
- [`bat`](https://github.com/sharkdp/bat) as a `cat` alternative with syntax
highlighting (and more).
- [`eza`](https://github.com/eza-community/eza) - a modern alternative to `ls`
- [`fish`](https://fishshell.com/) - I just prefer the UX over `bash` and `zsh`
  (and all the other alternatives)
    - [`fisher`](https://github.com/jorgebucaran/fisher) as plugin manager
- [`fd`](https://github.com/sharkdp/fd) - fast alternative to `find` with better
  UX.
- [`neovim`](https://neovim.io/)
- [`ripgrep`](https://github.com/BurntSushi/ripgrep) - blazing-fast alternative
to `grep` for faster searching
- [`starship`](https://starship.rs/) - super fast and configurable shell prompt with very
  sensible defaults.
- [`zoxide`](https://github.com/ajeetdsouza/zoxide) for smarter `cd` directory
changing.
- [`zellij`](https://zellij.dev/) - modern alternative to `tmux` with (IMO)
easier to grok keybindings and modes.
