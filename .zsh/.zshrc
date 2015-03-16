#! /usr/bin/env zsh
#
umask 022                   # default umask
bindkey -e                  # keybind  -> emacs like
setopt no_beep              # beep を無効化

setopt auto_pushd           # cd 時に Tab 補完
setopt pushd_to_home        # pushd を引数無しで実行した時に pushd ~ とする
setopt pushd_ignore_dups    # ディレクトリスタックに重複する物は古い方を削除

DIRSTACKSIZE=20
limit coredumpsize 0

setopt correct              # コマンドのスペル訂正
setopt rc_quotes            # '' で ' を表現(エスケープをちょっとだけ省く)
unsetopt correct_all        # 全ての引数のスペル訂正: 無効化

setopt auto_resume          # リダイレクトしてない suspend job を同じ操作で再開
setopt bg_nice              # bg の nice を低くして実行
setopt notify               # バックグラウンドジョブの状態変化を即時報告する
setopt nohup                # default は nohup
setopt nonomatch            # zsh: no matches found 対策

## functions treat as array
typeset -Uga chpwd_functions
typeset -Uga precmd_functions
typeset -Uga preexec_functions

## utilities
autoload -Uz colors; colors  # 色指定を $fg[red] 等で行なえるように.

HISTFILE=$ZDOTDIR/history/${USER}-zhistory
HISTSIZE=100000
SAVEHIST=HISTSIZE

setopt extended_history                # コマンドの開始時刻と経過時間を登録
unsetopt share_history                   # ヒストリの共有 for GNU Screen
setopt inc_append_history              # 履歴を直ぐに反映
setopt hist_ignore_space               # コマンド行先頭が空白の時登録しない
unsetopt hist_ignore_all_dups            # 重複ヒストリは古い方を削除
setopt hist_reduce_blanks              # 余分なスペースを削除
setopt hist_no_store                   # historyコマンドは登録しない
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
function history-all { history -E 1}   # 履歴の一覧を出力

export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true
## Options
setopt auto_list              # 補完候補を一覧で表示
setopt auto_param_slash       # 補完候補がディレクトリの場合, 末尾に / を追加
setopt auto_param_keys        # カッコの対応も補完
setopt list_packed            # 補完候補をできるだけ詰めて表示
setopt list_types             # 補完候補のファイル種別を識別
unsetopt list_beep            # 補完の beep を無効化
setopt rec_exact              # 曖昧補完を有効化
setopt interactive_comments   # コマンドでも # 以降をコメントとみなす
setopt magic_equal_subst      # = 以降も補完(--prefix= 等)
setopt complete_in_word       # コマンドの途中でもカーソル位置で補完
setopt always_last_prompt     # カーソル位置を保持してファイル名一覧を補完

## style
zstyle ':completion:*' menu select=2 # カーソルによる補完候補の選択を有効化
# 色指定に LS_COLORS を使用
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# 種別を別々に表示させるため, グループを空白に
zstyle ':completion:*' group-name ''
# ディレクトリ名の補完
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' keep-prefix
# リモートディレクトリも補完
zstyle ':completion:*' remote-access true
zstyle ':completion:*' completer \
    _oldlist _complete _match _ignored _approximate _list _history
## 補完候補の追加
[ -d $ZDOTDIR/modules/completions ] && \
    fpath+=( $ZDOTDIR/modules/zsh-completions/src $fpath)
# [ -d $ZDOTDIR/functions ] && \
#   fpath+=( $ZDOTDIR/functions $fpath)
typeset -gxU fpath
# autoload $ZDOTDIR/functions/*.zsh
# 初期化

setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
setopt prompt_percent    # %文字から始まる置換機能を有効に
unsetopt promptcr        # 被る時は右プロンプトを消す
setopt transient_rprompt # コマンド実行後は右プロンプトを消す

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git bzr svn hg
zstyle ':vcs_info:*' formats '%s:%b'
zstyle ':vcs_info:*' actionformats '%s:%b%a'
zstyle ':vcs_info:(svn|bzr)' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true
function prompt_vcs_info(){
    LANG=C vcs_info
    if [[ -n "$vcs_info_msg_0_" ]]; then
        ps_vcs_info="[%B%F{red}$vcs_info_msg_0_%f%b]"
    else
        ps_vcs_info=''
    fi
}
precmd_functions+=prompt_vcs_info

function count_prompt_chars (){
    print -n -P -- "$1" | sed -e $'s/\e\[[0-9;]*m//g' | wc -m | sed -e 's/ //g'
}
# precmd のプロンプト更新用関数
function update_prompt (){
    ## プロンプト: 1段目左
    local ps_user="%(!,%B%F{magenta}%n%b,%n)"
    local ps_host="%m"
    [[ -n ${SSH_CONNECTION} ]] && ps_host="%F{yellow}%m%f"
    # @see Zshをかわいくする.zshrcの設定
    # URL: http://qiita.com/kubosho_/items/c200680c26e509a4f41c
    # 横幅等を調整.
    # local ps_status="[%j]%(?.%B%F{green}.%B%F{blue})%(?!(*'-')%b!(*;-;%)%b)%f "
    local ps_status="%(?.%B%F{green}.%B%F{blue})%(?!ヽ(*ﾟд ﾟ)ノ%b!(*;-;%)%b)%f "
    local ps_mark="%(!,%B%F{magenta}#%f%b,%%)"
    # local prompt_1st_left="[$ps_user@$ps_host$chroot_info]"
    local prompt_1st_left="$ps_status"
    ## プロンプト: 1段目右(深さが8以上になったら省略)
    local prompt_1st_right="[%F{white}%(8~,%-2~/.../%1~,%~)%f]"
    ## 1段目行の残り文字列の計算
    local left_length=$(count_prompt_chars $prompt_1st_left)
    local right_length=$(count_prompt_chars $prompt_1st_right)
    local bar_rest_length=$[ COLUMNS - left_length - right_length -1 ]
    ## 1段目に水平線を引く
    local prompt_1st_hr=${(l:${bar_rest_length}::-:)}
    ## PROMPT の設定
    # PROMPT="$prompt_1st_left$prompt_1st_hr$prompt_1st_right-"$'\n'"$ps_status$ps_mark "
    PROMPT="$prompt_1st_left$prompt_1st_hr$prompt_1st_right-"$'\n'"$ps_mark "
    PROMPT2='|%j]> '
    SPROMPT="[%j]%B%F{red}%{$suggest%}(*'~'%)?<%b %U%r%u is correct? [n,y,a,e]:%f "
    # 右プロンプト
    RPROMPT="$ps_vcs_info"
}
precmd_functions+=update_prompt

# Git completion
fpath=(~/.zsh/completion $fpath)
autoload -U compinit
compinit -u

export MANPAGER='less -s'
export PAGER='less -R'
if whence lv >/dev/null ; then
    export PAGER=lv ;  export LV="-c -T8192 -l"
else
    alias lv=$PAGER
fi
whence vim >/dev/null && alias vi=vim
export EDITOR=vi

## ls
alias sl='ls'  #fxxk!!
export TIME_STYLE=long-iso
export LS_OPTIONS="-N -T 0 --time-style=$TIME_STYLE"
alias ls='ls -FG'
alias la='ls -haFG'
alias ll='ls -hlFG'
alias lla='ls -hlaFG'
alias lsd='ls -ld *(-/DN)'
alias man='LANG=C man'
if [ "$(uname)" == 'Darwin' ]; then
	alias vim="mvim --remote-tab-silent"
	alias vi="/usr/local/Cellar/vim/*/bin/vim"
fi
# PATH="/Applications/MacVim.app/Contents/MacOS:$PATH"

if hash anyenv 2>/dev/null; then
	eval "$(anyenv init -)"

	for D in `ls $HOME/.anyenv/envs`
		do
			export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
		done
fi

if [ ! -f $ZDOTDIR/.zshenv.zwc -o $ZDOTDIR/.zshenv -nt $ZDOTDIR/.zshenv.zwc ]; then
  zcompile $ZDOTDIR/.zshenv
fi
if [ ! -f $ZDOTDIR/.zshrc.zwc -o $ZDOTDIR/.zshrc -nt $ZDOTDIR/.zshrc.zwc ]; then
  zcompile $ZDOTDIR/.zshrc
fi
