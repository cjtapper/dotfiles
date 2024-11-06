.DEFAULT_GOAL:= help

.PHONY: install
install: ## Symlink all config and scripts
	stow dotfiles -t ~
	fish -c "fisher update"

.PHONY: uninstall
uninstall: ## Remove symlinks
	stow --delete dotfiles -t ~

.PHONY: bootstrap
bootstrap: ## Bootstrap the environment
	./scripts/makefile/install-fisher.fish

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
