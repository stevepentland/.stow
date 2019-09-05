export WORKON_HOME=~/envs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.bin
export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/steve/.local/share/flatpak/exports/share

# Recording Functions for CLI
makeDemo() {
	if [ -z "${MAKING_DEMO}" ]; then
		MAKING_DEMO=true
	fi

	source ~/.zshrc
}

doneDemo() {
	unset MAKING_DEMO
	source ~/.zshrc
}
