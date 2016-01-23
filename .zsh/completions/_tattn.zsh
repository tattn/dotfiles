
_tattn() {
  local context state line curcontext="$curcontext"

  if (( CURRENT > 2 )); then
    (( CURRENT-- ))
    shift words
    _call_function - "_tattn_${words[1]}" || _nothing
  else
    __tattn_commands
  fi
}

__tattn_commands() {
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
				'tattn[show tattn]' \
				'trend[show trends]' \
				'ascii[show ascii art]' \
				'unpack[unpack a file]'
			;;
	esac
}

_tattn_ascii() {
  local context state line curcontext="$curcontext"

  if (( CURRENT > 2 )); then
    (( CURRENT-- ))
    shift words
	if [ ${words[1]} = image ]; then
		_arguments '*: :_files'
	fi
  else
	_arguments \
		'(- *)'{-h,--help}'[show help]' \
		"-f+[specify font]:font:->fonts" \
		'*: :->modes'

	case $state in
		modes)
			_values \
				'mode' \
				'text[show trends]' \
				'image[show ascii art]'
			;;
	esac
  fi
}

_tattn_unpack() {
  local context state line curcontext="$curcontext"

  _arguments \
	  '(- *)'{-h,--help}'[show help]' \
	  "-f+[specify font]:font:->fonts" \
	  '*: :_files'
}

compdef _tattn tattn

