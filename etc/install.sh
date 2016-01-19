if [ -z $DOTPATH ]; then
    echo '$DOTPATH was not found' >&2
    exit 1
fi

. $DOTPATH/etc/utils.sh

check() {
	if has $1; then
		echo "====> Pass $1"
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
		echo "====> Install $dir"
		git clone https://github.com/riywo/anyenv ~/.anyenv
		source dotfiles/.zsh/.zshrc
	fi
fi

##### Rbenv
if check rbenv; then
	echo "====> Install Rbenv"
	anyenv install rbenv

	echo "====> Install Rbenv-binstubs"
	mkdir -p ~/.anyenv/envs/rbenv/plugins
	pushd ~/.anyenv/envs/rbenv/plugins
	git clone git://github.com/ianheggie/rbenv-binstubs.git
	popd
fi

##### Pyenv
if check pyenv; then
	echo "====> Install Pyenv"
	anyenv install pyenv
fi


if has zsh; then
	mkdir -p $DOTPATH/.zsh/plugins
	pushd $DOTPATH/.zsh/plugins
	if [ ! -d $DOTPATH/.zsh/plugins/zaw ]; then
		echo "====> Install a zsh plugin [zaw]"
		git clone git://github.com/zsh-users/zaw.git
	fi
	if [ ! -d $DOTPATH/.zsh/plugins/bd ]; then
		echo "====> Install a zsh plugin [bd]"
		mkdir -p $DOTPATH/.zsh/plugins/bd
		curl https://raw.githubusercontent.com/Tarrasch/zsh-bd/master/bd.zsh > $DOTPATH/.zsh/plugins/bd/bd.zsh
	fi
	if [ ! -d $DOTPATH/.zsh/plugins/autojump ]; then
		echo "====> Install a zsh plugin [autojump]"
		git clone git://github.com/joelthelion/autojump.git
		pushd autojump
		./install.py
		popd
	fi
	popd
fi


if is_osx; then
	. $DOTPATH/etc/osx/install.sh
fi

