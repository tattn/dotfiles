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

check_file() {
	if [ -e $1 ]; then
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
		echo 'Please run `exec $SHELL -l` and make install-utility'
		exit 0
	fi
else
	log_info "====> Set up anyenv"
	if check_file ~/.config/anyenv/anyenv-install; then
		anyenv install --init
	fi
fi

if [ ! -d ~/.anyenv/plugins/anyenv-update ]; then
	log_info "====> Install anyenv-update"
	git clone https://github.com/znz/anyenv-update.git ~/.anyenv/plugins/anyenv-update
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
	#exec $SHELL -l
fi

##### Pyenv
if check pyenv; then
	log_info "====> Install Pyenv"
	anyenv install pyenv
	log_info "====> Install Pyenv-virtualenv"
	git clone https://github.com/yyuu/pyenv-virtualenv ~/.anyenv/envs/pyenv/plugins/pyenv-virtualenv
	#exec $SHELL -l
fi

##### Nodenv
if check nodenv; then
	log_info "====> Install nodenv"
	anyenv install nodenv
	#exec $SHELL -l
fi

zsh_plugin() {
	if [ -d $DOTPATH/.zsh/plugins/$1 ]; then
		return 1
	fi
	log_info "====> Install a zsh plugin [$1]"
	return 0
}

gitclone() {
	git clone git://github.com/$1.git
}

gitcurl() {
	curl https://raw.githubusercontent.com/$1/master/$2 > $3
}

_pushd() {
	pushd $1 2>/dev/null
}

_popd() {
	popd 2>/dev/null
}

if has zsh; then
	if [ ! -d ~/.zplug ]; then
		curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
		echo "need to reload .zshrc & .zshenv"
		exit 0
	fi
	zplug install

	mkdir -p $DOTPATH/.zsh/plugins
	_pushd $DOTPATH/.zsh/plugins
	# zsh_plugin zaw && gitclone zsh-users/zaw
	_popd
fi

if [ ! -d ~/.tmux/plugins/tpm ]; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi


detect_os
. $DOTPATH/etc/$_PLATFORM/install

log_pass "$0: Finish!!"
