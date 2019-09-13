#!/usr/bin/env bash

# Simple setup script to get everything bootstrapped
PACKAGES=("neovim" "zsh" "stow" "ripgrep" "exa" "restic" "xclip" "curl")

if command -v dnf > /dev/null 2>&1; then
	echo "Found dnf, assuming Fedora"
	PACKAGES+=("bat")
	sudo dnf install --assumeyes "${PACKAGES[@]}"
elif command -v pacman > /dev/null 2>&1; then
	echo "Found pacman, assuming Arch"
	PACKAGES+=("bat")
	sudo pacman -S --noconfirm "${PACKAGES[@]}"
elif command -v apt > /dev/null 2>&1; then
	echo "Found apt, assuming Ubuntu"
	if command -v mawk > /dev/null 2>&1; then
		sudo apt-get install -y gawk
		sudo apt-get remove -y mawk
	fi
	sudo apt-get install -y "${PACKAGES[@]}"
else
	echo "Cannot find package manager"
	exit 1
fi

# Switch default shell to zsh
chsh -s "$(command -v zsh)"

# Install zplug
export ZPLUG_HOME=~/.zplug
git clone https://github.com/zplug/zplug $ZPLUG_HOME

# Stow packages
stow git systemd
stow --no-folding work gnupg

if [ -f ~/.zshrc ]; then
	rm ~/.zshrc
fi
stow zsh
