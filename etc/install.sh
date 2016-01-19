if [ -z $DOTPATH ]; then
    echo '$DOTPATH was not found' >&2
    exit 1
fi

. $DOTPATH/etc/utils.sh

has() {
	if type $1 > /dev/null 2>&1; then
		echo "====> Pass $1"
		return 0
	else
		return 1
	fi
}

##### Anyenv
if ! has anyenv; then
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
if ! has rbenv; then
	echo "====> Install Rbenv"
	anyenv install rbenv

	echo "====> Install Rbenv-binstubs"
	mkdir -p ~/.anyenv/envs/rbenv/plugins
	pushd ~/.anyenv/envs/rbenv/plugins
	git clone git://github.com/ianheggie/rbenv-binstubs.git
	popd
fi

##### Pyenv
if ! has pyenv; then
	echo "====> Install Pyenv"
	anyenv install pyenv
fi

if is_osx; then
	echo $(osname)
fi
echo $PLATFORM



