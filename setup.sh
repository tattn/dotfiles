#! /bin/bash
if [ -e ~/.vimrc ]; then
	rm ~/.vimrc
fi
ln -s ~/dotfiles/.vimrc ~/.vimrc

if [ -e ~/.gitconfig ]; then
	rm ~/.gitconfig
fi
ln -s ~/dotfiles/.gitconfig ~/.gitconfig

if [ -e ~/.vim ]; then
	rm -r ~/.vim
fi
ln -s ~/dotfiles/.vim ~/.vim

if [ -e ~/.zshenv ]; then
    rm ~/.zshenv
fi
ln -s ~/dotfiles/.zshenv ~/.zshenv

if [ -e ~/.xvimrc ]; then
    rm ~/.xvimrc
fi
ln -s ~/dotfiles/.xvimrc ~/.xvimrc

if [ -e ~/.tmux.conf ]; then
    rm ~/.tmux.conf
fi
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf

