if ! is_osx; then
	die "Error: only supported with osx"
fi

mkdir -p $HOME/.config

if [ ! -e $HOME/.config/karabiner ]; then
	ln -s $DOTPATH/misc/osx/karabiner $HOME/.config/
fi

