#!/usr/bin/env bash

# Simple setup script to get everything bootstrapped
PACKAGES=("git" "neovim" "zsh" "stow" "ripgrep" "exa" "restic" "xclip")

if [ -f /usr/bin/dnf ]; then
	echo "Found dnf, assuming Fedora"
	PACKAGES+=("bat")
	sudo dnf install --assumeyes "${PACKAGES[@]}"
elif [ -f /usr/bin/pacman ]; then
	echo "Found pacman, assuming Arch"
	PACKAGES+=("bat")
	sudo pacman -S --noconfirm "${PACKAGES[@]}"
elif [ -f /usr/bin/apt ]; then
	echo "Found apt, assuming Ubuntu"
	sudo apt-get install -y "${PACKAGES[@]}"
	echo "Remember to get 'bat' installed!"
else
	echo "Cannot find package manager"
	exit 1
fi

# Switch default shell to zsh
chsh -s "$(command -v zsh)"

# Install zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# Stow packages
stow git systemd
stow --no-folding work gnupg

if [ -f ~/.zshrc ]; then
	rm ~/.zshrc
fi
stow zsh
