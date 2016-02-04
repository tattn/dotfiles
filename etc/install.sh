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
		exec $SHELL -l
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
	exec $SHELL -l
fi

##### Pyenv
if check pyenv; then
	log_info "====> Install Pyenv"
	anyenv install pyenv
	exec $SHELL -l
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
	mkdir -p $DOTPATH/.zsh/plugins
	_pushd $DOTPATH/.zsh/plugins
	zsh_plugin zaw && gitclone zsh-users/zaw
	if zsh_plugin bd; then
		mkdir -p bd
		# curl https://raw.githubusercontent.com/Tarrasch/zsh-bd/master/bd.zsh > bd/bd.zsh
		gitcurl Tarrasch/zsh-bd bd.zsh bd/bd.zsh
	fi
	if zsh_plugin k; then
		mkdir -p k
		curl https://raw.githubusercontent.com/rimraf/k/master/k.sh > k/k.sh
	fi
	if zsh_plugin autojump; then
		gitclone joelthelion/autojump
		pushd autojump && ./install.py && popd
	fi
	zsh_plugin "dircolors-solarized" && gitclone seebi/dircolors-solarized
	zsh_plugin "zsh-completions" && gitclone zsh-users/zsh-completions
	zsh_plugin "cd-gitroot" && gitclone mollifier/cd-gitroot
	_popd
fi


detect_os
. $DOTPATH/etc/$_PLATFORM/install

log_pass "$0: Finish!!"
