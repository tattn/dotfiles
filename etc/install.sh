if [ -z $DOTPATH ]; then
    echo '$DOTPATH was not found' >&2
    exit 1
fi

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp
#             until this script has finished
while true
do
    sudo -n true
    sleep 60;
    kill -0 "$$" || exit
done 2>/dev/null &

. $DOTPATH/etc/utils.sh

check() {
	if has $1; then
		log_pass "====> Pass $1"
		return 1 # false
	else
		return 0
	fi
}

##### Anyenv
if check anyenv; then
	dir=~/.anyenv
	if [ -d $dir ]; then
		source dotfiles/.zsh/.zshrc
	else
		log_info "====> Install $dir"
		git clone https://github.com/riywo/anyenv ~/.anyenv
		source dotfiles/.zsh/.zshrc
	fi
fi

##### Rbenv
if check rbenv; then
	log_info "====> Install Rbenv"
	anyenv install rbenv

	log_info "====> Install Rbenv-binstubs"
	mkdir -p ~/.anyenv/envs/rbenv/plugins
	pushd ~/.anyenv/envs/rbenv/plugins
	git clone git://github.com/ianheggie/rbenv-binstubs.git
	popd
fi

##### Pyenv
if check pyenv; then
	log_info "====> Install Pyenv"
	anyenv install pyenv
fi

install_zsh_plugin() {
	if [ -d $DOTPATH/.zsh/plugins/$1 ]; then
		return 1
	fi
	log_info "====> Install a zsh plugin [$1]"
	return 0
}

if has zsh; then
	mkdir -p $DOTPATH/.zsh/plugins
	pushd $DOTPATH/.zsh/plugins
	if install_zsh_plugin zaw; then
		git clone git://github.com/zsh-users/zaw.git
	fi
	if install_zsh_plugin bd; then
		mkdir -p $DOTPATH/.zsh/plugins/bd
		curl https://raw.githubusercontent.com/Tarrasch/zsh-bd/master/bd.zsh > $DOTPATH/.zsh/plugins/bd/bd.zsh
	fi
	if install_zsh_plugin autojump; then
		git clone git://github.com/joelthelion/autojump.git
		pushd autojump
		./install.py
		popd
	fi
	if install_zsh_plugin "dircolors-solarized"; then
		git clone https://github.com/seebi/dircolors-solarized.git
	fi
	popd
fi


detect_os
. $DOTPATH/etc/$PLATFORM/install

log_pass "$0: Finish!!"
