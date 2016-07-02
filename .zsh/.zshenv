#! /usr/bin/env zsh
# -*- mode: sh; coding: utf-8; indent-tabs-mode: nil -*-

# Load utilities
source "$DOTPATH/etc/utils.sh"

export LANGUAGE=ja_JP.UTF-8
export LANG=${LANGUAGE}
export LC_ALL=${LANGUAGE}
export LC_CTYPE=${LANGUAGE}
export DIRSTACKSIZE=20
export HISTFILE=$ZDOTDIR/history/${USER}-zhistory
export HISTSIZE=100000
export SAVEHIST=HISTSIZE

# Editor
whence vim >/dev/null && alias vi=vim
export EDITOR=vi

# Pager
export PAGER=less
# Less status line
export LESS='-R -f -X -i -P ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'
export LESSCHARSET='utf-8'

# LESS man page colors (makes Man pages more readable).
alias man='LANG=C man'
export MANPAGER='less -s'
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[00;44;37m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

path=(
  {/usr/local,/usr,/usr/local/bin,/usr/bin}
  {/bin,/sbin}(N-/)
  $DOTPATH/bin
  $HOME/bin(N-/)
  $HOME/.anyenv/bin(N-/)
  #/usr/local/share/git-core/contrib/diff-highlight(N-/)
)
manpath=(
  {/usr,/usr/local}/share/man(N-/)
)

if has anyenv; then
	for D in `ls $HOME/.anyenv/envs`
	do
		path=($HOME/.anyenv/envs/$D/shims $path)
	done
fi

[ -z "$ld_library_path" ] && typeset -xT LD_LIBRARY_PATH ld_library_path
[ -z "$include" ] && typeset -xT INCLUDE include
typeset -xU ld_library_path include

# unify paths
typeset -gxU path cdpath fpath manpath ld_library_path include

is_osx && export HOMEBREW_CASK_OPTS="--appdir=/Applications"

export XDG_CONFIG_HOME=~/.config

[ -f $HOME/.local_zshrc ] && source $HOME/.local_zshrc
