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

if is_arm; then
    log_pass "Homebrew: ARM Mac"
	pushd /opt
	sudo mkdir -p homebrew
	sudo chown $USER:admin homebrew
	curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
	popd
	export PATH="$PATH:/opt/homebrew/bin"
else
    log_pass "Homebrew: Intel Mac"
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if has brew; then
    brew doctor
else
    die "Error: brew: failed to install"
fi

log_pass "Homebrew: installed successfully"
