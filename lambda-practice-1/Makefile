SHELL := /bin/bash

# Local

.PHONY: config
config:
	@git config --global --add safe.directory '*'

.PHONY: alias
alias:
	@echo "alias tf=terraform" >> ~/.profile
	echo "alias m=make" >> ~/.profile
	echo "alias tf=terraform" >> ~/.profile
	source ~/.profile

.DEFAULT_GOAL := config