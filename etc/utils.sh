export _PLATFORM

is_bash() {
    [ -n "$BASH_VERSION" ]
}

is_zsh() {
    [ -n "$ZSH_VERSION" ]
}

lower() {
	tr "[:upper:]" "[:lower:]" <<< $1
}

osname() {
    lower $(uname)
}

detect_os() {
	export _PLATFORM
    case "$(osname)" in
        *'linux'*)  _PLATFORM='linux'   ;;
        *'darwin'*) _PLATFORM='osx'     ;;
        *'bsd'*)    _PLATFORM='bsd'     ;;
        *)          _PLATFORM='unknown' ;;
    esac
}

is_osx() {
    detect_os
    if [ "$_PLATFORM" = "osx" ]; then
        return 0
    else
        return 1
    fi
}

is_arm() {
	test $(uname -m) == "arm64";
}

is_linux() {
    detect_os
    if [ "$_PLATFORM" = "linux" ]; then
        return 0
    else
        return 1
    fi
}

is_bsd() {
    os_detect
    if [ "$_PLATFORM" = "bsd" ]; then
        return 0
    else
        return 1
    fi
}

e_newline() {
    printf "\n"
}

e_header() {
    printf " \033[37;1m%s\033[m\n" "$*"
}

e_error() {
    printf " \033[31m%s\033[m\n" "✖ $*" 1>&2
}

e_warning() {
    printf " \033[31m%s\033[m\n" "$*"
}

e_done() {
    printf " \033[37;1m%s\033[m...\033[32mOK\033[m\n" "✔ $*"
}

e_arrow() {
    printf " \033[37;1m%s\033[m\n" "➜ $*"
}

e_indent() {
    for ((i=0; i<${1:-4}; i++)); do
        echon " "
    done
    if [ -n "$2" ]; then
        echo "$2"
    else
        cat <&0
    fi
}

e_success() {
    printf " \033[37;1m%s\033[m%s...\033[32mOK\033[m\n" "✔ " "$*"
}

e_failure() {
    die "${1:-$FUNCNAME}"
}

ink() {
    if [ "$#" -eq 0 -o "$#" -gt 2 ]; then
        echo "Usage: ink <color> <text>"
        echo "Colors:"
        echo "  black, white, red, green, yellow, blue, purple, cyan, gray"
        return 1
    fi

    local open="\033["
    local close="${open}0m"
    local black="0;30m"
    local red="1;31m"
    local green="1;32m"
    local yellow="1;33m"
    local blue="1;34m"
    local purple="1;35m"
    local cyan="1;36m"
    local gray="0;37m"
    local white="$close"

    local text="$1"
    local color="$close"

    if [ "$#" -eq 2 ]; then
        text="$2"
        case "$1" in
            black | red | green | yellow | blue | purple | cyan | gray | white)
            eval color="\$$1"
            ;;
        esac
    fi

    printf "${open}${color}${text}${close}"
}

logging() {
    if [ "$#" -eq 0 -o "$#" -gt 2 ]; then
        echo "Usage: ink <fmt> <msg>"
        echo "Formatting Options:"
        echo "  TITLE, ERROR, WARN, INFO, SUCCESS"
        return 1
    fi

    local color=
    local text="$2"

    case "$1" in
        TITLE)
            color=yellow
            ;;
        ERROR | WARN)
            color=red
            ;;
        INFO)
            color=blue
            ;;
        SUCCESS)
            color=green
            ;;
        *)
            text="$1"
    esac

    timestamp() {
        ink gray "["
        ink purple "$(date +%H:%M:%S)"
        ink gray "] "
    }

    timestamp; ink "$color" "$text"; echo
}

log_pass() {
    logging SUCCESS "$1"
}

log_fail() {
    logging ERROR "$1" 1>&2
}

log_fail() {
    logging WARN "$1"
}

log_info() {
    logging INFO "$1"
}

log_echo() {
    logging TITLE "$1"
}

has() {
    which "$1" >/dev/null 2>&1
    return $?
}

die() {
    e_error "$1" 1>&2
    exit "${2:-1}"
}

# returns true if current shell is first shell
is_login_shell() {
    [ "$SHLVL" = 1 ]
}

is_git_repo() {
    git rev-parse --is-inside-work-tree &>/dev/null
    return $?
}

# returns true if GNU screen is running
is_screen_running() {
    [ ! -z "$STY" ]
}

is_tmux_runnning() {
    [ ! -z "$TMUX" ]
}

is_screen_or_tmux_running() {
    is_screen_running || is_tmux_runnning
}

is_ssh_running() {
    [ ! -z "$SSH_CLIENT" ]
}

# returns true if $1 is int type
is_num() {
    if [ $# -eq 0 ]; then
        cat <&0
    else
        echo "$1"
    fi | grep -E '^[0-9]+$' >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        return 0
    else
        return 1
    fi
}

# returns true if the specified string contains
contains() {
    string="$1"
    substring="$2"
    if [ "${string#*$substring}" != "$string" ]; then
        return 0    # $substring is in $string
    else
        return 1    # $substring is not in $string
    fi
}

# returns the length of $1
len() {
    local length
    length="$(echo "$1" | wc -c | sed -e 's/ *//')"
    echo $(("$length" - 1))
}

# returns true if $1 consists of $_BLANK_
is_empty() {
    if [ $# -eq 0 ]; then
        cat <&0
    else
        echo "$1"
    fi | grep -E "^[$_BLANK_]*$" >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        return 0
    else
        return 1
    fi
}


