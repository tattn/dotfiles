
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
				'extract[extract a file]' \
				'image[edit an image]'
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

_tattn_extract() {
  local context state line curcontext="$curcontext"

  _arguments \
	  '(- *)'{-h,--help}'[show help]' \
	  '*: :_files'
}

_tattn_image() {
  local context state line curcontext="$curcontext"

  if (( CURRENT > 2 )); then
    (( CURRENT-- ))
    shift words
	if [ ${words[1]} = resize ]; then
		_arguments \
			'(- *)--help[show help]' \
			'*: :_files'
	fi
  else
	_arguments \
		'(- *)'{-h,--help}'[show help]' \
		'*: :->modes'

	case $state in
		modes)
			_values \
				'mode' \
				'resize[resize an image]'
			;;
	esac
  fi
}

compdef _tattn tattn

