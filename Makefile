.PHONY: bootstrap
bootstrap: ## install pre-dependencies needed to install everything
	PIP_REQUIRE_VIRTUALENV=false pip install -U -r requirements.txt
	pipx install ansible-base
