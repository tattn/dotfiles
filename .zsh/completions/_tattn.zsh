_tattn() {
    _arguments \
        '(- *)'{-h,--help}'[show help]' \
        '*: :->modes'

    case $state in
        modes)
            _values \
                'mode' \
                'neko[kawaii normal neko]' \
                'usagi[kawaii usa-neko]' \
                'kuma[kawaii kuma-neko]' \
                'github[kawaii octcat]' \
                'trend[show trends]'
            ;;
    esac
}

compdef _tattn tattn

