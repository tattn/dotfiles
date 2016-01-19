mkdir -p $DOTPATH/plugins

if [ ! -d $DOTPATH/plugins/solarized ]; then

	echo "====> Install solarized"
	pushd $DOTPATH/plugins
	git clone https://github.com/altercation/solarized
	popd
fi
