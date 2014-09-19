#! /bin/bash
if [ -e ~/.vimrc ]; then
	rm ~/.vimrc
fi
ln -s ~/dotfiles/.vimrc ~/.vimrc

if [ -e ~/.gitconfig ]; then
	rm ~/.gitconfig
fi
ln -s ~/dotfiles/.gitconfig ~/.gitconfig

if [ -e ~/.vimrc ]; then
	rm -r ~/.vim
fi
ln -s ~/dotfiles/.vim ~/.vim

