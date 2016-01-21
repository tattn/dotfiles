
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
		"-f+[specify font]:font:->fonts" \
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
				'ascii[show ascii art]'
			;;
		ascii)
			_values \
				'mode' \
				'text[show trends]' \
				'image[show ascii art]'
			;;
	esac
}

_tattn_ascii() {
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
}


compdef _tattn tattn

