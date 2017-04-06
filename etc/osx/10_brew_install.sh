if ! has brew; then
    die "Error: require brew"
fi

brew tap Homebrew/bundle
brew bundle

