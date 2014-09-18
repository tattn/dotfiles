#! /bin/bash
if [-e ~/.vimrc]; then
	rm ~/.vimrc
fi
ln -s ~/dotfiles/.vimrc ~/.vimrc

if [-e ~/.vimrc]; then
	rm ~/.gitconfig
fi
ln -s ~/dotfiles/.gitconfig ~/.gitconfig

