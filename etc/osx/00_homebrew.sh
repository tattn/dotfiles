if ! is_osx; then
	die "Error: only supported with osx"
fi

if has brew; then
    log_pass "Homebrew: already installed"
    return
fi

if ! has ruby; then
    die "Error: require ruby"
fi

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
if has brew; then
    brew doctor
else
    die "Error: brew: failed to install"
fi

log_pass "Homebrew: installed successfully"
