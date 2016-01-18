##### Anyenv
if type anyenv > /dev/null 2>&1; then
	echo "====> Pass anyenv"
else
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
if type rbenv > /dev/null 2>&1; then
	echo "====> Pass rbenv"
else
	echo "====> Install Rbenv"
	anyenv install rbenv

	echo "====> Install Rbenv-binstubs"
	mkdir -p ~/.anyenv/envs/rbenv/plugins
	pushd ~/.anyenv/envs/rbenv/plugins
	git clone git://github.com/ianheggie/rbenv-binstubs.git
	popd
fi

##### Pyenv
if type pyenv > /dev/null 2>&1; then
	echo "====> Pass pyenv"
else
	echo "====> Install Pyenv"
	anyenv install pyenv
fi

