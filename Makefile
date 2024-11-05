.PHONY: install
install:
	stow dotfiles -t ~

.PHONY: uninstall
uninstall:
	stow --delete dotfiles -t ~
