#! /usr/bin/env zsh

# Load utilities
source "$DOTPATH/etc/utils.sh"

umask 022                      # default umask
limit coredumpsize 0
bindkey -e                     # keybind  -> emacs like
setopt no_beep                 # beep を無効化
setopt auto_pushd              # cd 時に Tab 補完
setopt pushd_to_home           # pushd を引数無しで実行した時に pushd ~ とする
setopt pushd_ignore_dups       # ディレクトリスタックに重複する物は古い方を削除
setopt correct                 # コマンドのスペル訂正
setopt rc_quotes               # '' で ' を表現(エスケープをちょっとだけ省く)
setopt auto_resume             # リダイレクトしてない suspend job を同じ操作で再開
setopt bg_nice                 # bg の nice を低くして実行
setopt notify                  # バックグラウンドジョブの状態変化を即時報告する
setopt nohup                   # default は nohup
setopt nonomatch               # zsh: no matches found 対策
unsetopt correct_all           # 全ての引数のスペル訂正: 無効化

setopt extended_history        # コマンドの開始時刻と経過時間を登録
setopt inc_append_history      # 履歴を直ぐに反映
setopt hist_ignore_space       # コマンド行先頭が空白の時登録しない
setopt hist_reduce_blanks      # 余分なスペースを削除
setopt hist_no_store           # historyコマンドは登録しない
unsetopt share_history         # ヒストリの共有 for GNU Screen
unsetopt hist_ignore_all_dups  # 重複ヒストリは古い方を削除
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
function history-all { history -E 1}   # 履歴の一覧を出力

setopt auto_list               # 補完候補を一覧で表示
setopt auto_param_slash        # 補完候補がディレクトリの場合, 末尾に / を追加
setopt auto_param_keys         # カッコの対応も補完
setopt list_packed             # 補完候補をできるだけ詰めて表示
setopt list_types              # 補完候補のファイル種別を識別
unsetopt list_beep             # 補完の beep を無効化
setopt rec_exact               # 曖昧補完を有効化
setopt interactive_comments    # コマンドでも # 以降をコメントとみなす
setopt magic_equal_subst       # = 以降も補完(--prefix= 等)
setopt complete_in_word        # コマンドの途中でもカーソル位置で補完
setopt always_last_prompt      # カーソル位置を保持してファイル名一覧を補完
autoload -Uz colors; colors    # 色指定を $fg[red] 等で行なえるように.
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true

typeset -Uga chpwd_functions
typeset -Uga precmd_functions
typeset -Uga preexec_functions

# recent-dirs
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 500 # cdrの履歴を保存する個数
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':filter-select:highlight' selected fg=black,bg=white,standout
zstyle ':filter-select' case-insensitive yes

autoload -U compinit && compinit -u
zstyle ':completion:*' menu select=2 # カーソルによる補完候補の選択を有効化
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # 色指定に LS_COLORS を使用
zstyle ':completion:*' group-name '' # 種別を別々に表示させるため, グループを空白に
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # ディレクトリ名の補完
zstyle ':completion:*' keep-prefix
zstyle ':completion:*' remote-access true # リモートディレクトリも補完
zstyle ':completion:*' completer \
    _oldlist _complete _match _ignored _approximate _list _history
zstyle ':completion:*' recent-dirs-insert both # Add recent-dirs

# load my prompt style
source $ZDOTDIR/.zprompt
source $ZDOTDIR/completions/_tattn.zsh

# Set tab title automatically
function chpwd() { echo -ne "\033]0;$(pwd | rev | awk -F \/ '{print "/"$1"/"$2}'| rev)\007"}


## ls
export TIME_STYLE=long-iso
export LS_OPTIONS="-N -T 0 --time-style=$TIME_STYLE"
alias sl='ls'
alias ls='ls -FG'
alias la='ls -haFG'
alias ll='ls -hlFG'
alias lla='ls -hlaFG'
alias lsd='ls -ld *(-/DN)'
if is_osx; then
	alias ls='gls --color=auto -FG'
	alias dircolors='gdircolors'
fi

alias reload='exec zsh -l'

alias be='bundle exec'

## Docker
if has docker; then
	# Get latest container ID
	alias docl="docker ps -l -q"
	# Get container process
	alias docps="docker ps"
	# Get process included stop container
	alias docpa="docker ps -a"
	# Get images
	alias doci="docker images"
	# Get container IP, e.g., $docip `docl`
	alias docip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
	# Run deamonized container, e.g., $dkd base /bin/echo hello
	alias docrd="docker run -d -P"
	# Run interactive container, e.g., $dki base /bin/bash
	alias docri="docker run -i -t -P"
	# Stop all containers
	docstop() { docker stop $(docker ps -a -q); }
	# Remove all containers
	docrm() { docker rm $(docker ps -a -q); }
	# Stop and Remove all containers
	alias docrmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'
	# Remove all images
	docrmi() { docker rmi $(docker images -q); }
	# Show all alias related docker
	docalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }
fi

## Apache Spark
if has spark-shell; then
	if is_osx; then
		export SPARK_HOME=/usr/local/Cellar/apache-spark/2.1.0
		export PATH=$PATH:$SPARK_HOME/bin
	fi
fi

has anyenv && eval "$(anyenv init - zsh)"
has rbenv && eval "$(rbenv init - zsh)"
has pyenv && eval "$(pyenv virtualenv-init -)"
has nodenv && eval "$(nodenv init -)"
has direnv && eval "$(direnv hook zsh)"
has hub    && eval "$(hub alias -s)"

# zplug
if [ -f ~/.zplug/init.zsh ]; then
	source ${ZDOTDIR}/.zplug
fi

ZSH_PLUGINS=$ZDOTDIR/plugins
fpath=(
	# $ZDOTDIR/completions/hub.zsh_completion(N-/)
	$fpath
)

# start up
tattn neko
alias tt=tattn
