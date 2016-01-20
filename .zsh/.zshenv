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
export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

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
# if whence lv >/dev/null ; then
#     export PAGER=lv ;  export LV="-c -T8192 -l"
# else
#     alias lv=$PAGER
# fi
#

path=(
  $DOTPATH/bin
  $HOME/.anyenv/bin
  /usr/local/bin
  /usr/local/Cellar/qt5/5.3.2/bin/
  /usr/local/Cellar/llvm/3.6.0/bin/
  /usr/local/texlive/2014/bin/x86_64-darwin/
  /usr/local/texlive/2015/bin/x86_64-darwin
  /Applications/Android/ndk
  /Applications/Android/sdk/platform-tools
  {/usr/local,/usr,}{/bin,/sbin}(N-/)
)
manpath=(
    {/usr,/usr/local}/share/man(N-/)
)
typeset -gxU path
typeset -gxU manpath

[ -z "$ld_library_path" ] && typeset -xT LD_LIBRARY_PATH ld_library_path
[ -z "$include" ] && typeset -xT INCLUDE include
typeset -xU ld_library_path include

if has anyenv; then
	for D in `ls $HOME/.anyenv/envs`
	do
		path=( $HOME/.anyenv/envs/$D/shims $path )
	done
fi

## function: auto-zcompile & source
function _auto_zcompile_source() {
    local A; A=$1
    [[ -e "${A:r}.zwc" ]] && [[ "$A" -ot "${A:r}.zwc" ]] ||
    zcompile $A >/dev/null 2>&1 ; source $A
}

[ -f $ZDOTDIR/proxy ] && _auto_zcompile_source $ZDOTDIR/proxy

[ -d $HOME/bin ] && path=( $HOME/bin $path )

### duplicate cleaning
typeset -gxU path cdpath fpath manpath ld_library_path include

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

