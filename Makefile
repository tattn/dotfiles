DOTPATH      := ~/dotfiles
ALL_DOTFILES := $(notdir $(shell find . -maxdepth 1 -name '\.*'))
IGNORES      := . .DS_Store .git .gitmodule .travis.yml
DOTFILES     := $(filter-out $(wildcard ${IGNORES}), ${ALL_DOTFILES})

all: install

help:
	@echo "make deploy   => create symlinks to home"
	@echo "make update   => Pull changes from the repository"


deploy:
	@echo '=====> deploy dotfiles...'
	@$(foreach val, ${DOTFILES}, ln -sfnv $(abspath ${val}) ${HOME}/${val};)
# @$(foreach val, ${DOTFILES}, sudo chown `whoami` ${HOME}/${val};)


update:
	@echo '=====> update dotfiles...'
	git pull origin master

up: update


install: update deploy


install-utility:
	@DOTPATH=$(DOTPATH) bash ${DOTPATH}/etc/install.sh

