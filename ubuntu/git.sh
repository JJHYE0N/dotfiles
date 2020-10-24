#!/usr/bin/env bash

workspace="$HOME/workspace"
dotfiles="$HOME/workspace/ubuntu-fresh/dotfiles"

install_diff_so_fancy() {
	git clone "https://github.com/so-fancy/diff-so-fancy" "$workspace/diff-so-fancy"
	# Add $HOME/.cargo to $PATH variable.
	cat <<EOT >> "$HOME/.profile"

# Add diff-so-fancy path to \$PATH variable
if [ -d "\$HOME/workspace/diff-so-fancy" ]; then
    PATH="\$HOME/workspace/diff-so-fancy:\$PATH"
fi
EOT
	git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
}

install_tig() {
	local dependencies=( "libncursesw6" )
	sudo apt install ${dependencies[@]} &&
	git clone "https://github.com/jonas/tig" "$workspace/tig" &&
		(cd "$workspace/tig" && make && sudo make install prefix=/usr/local)
}

set_ssh() {
	ssh-keygen -t rsa -b 4096 -C "gentlebuuny@gmail.com" &&
		eval "$(ssh-agent -s)" &&
		ssh-add ~/.ssh/id_rsa &&
		git remote set-url origin "https://github.com/hakumaku/ubuntu-fresh" &&
		xclip -sel clip < ~/.ssh/id_rsa.pub &&
		firefox https://github.com/settings/ssh/new
}

sudo apt install git &&
	install_diff_so_fancy &&
	install_tig &&
	(cd && ln -s $dotfiles/git/.gitconfig) && set_ssh
