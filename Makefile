.PHONY: install
install:
	stow dotfiles -t ~
	fisher update

.PHONY: uninstall
uninstall:
	stow --delete dotfiles -t ~

.PHONY: bootstrap
bootstrap:
	./scripts/makefile/install-fisher.fish
