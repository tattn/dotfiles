. $DOTPATH/etc/utils.sh

function usage {
    cat <<EOF
Usage:
    $(basename ${0}) [<command>] [<options>]

Commands:
    resize       -w <width> [-h <height>] input -o output       Resize an image

Options:
    --version, -v     print $(basename ${0}) version
    --help, -h        print this
EOF
}

function version {
    echo "$(basename ${0}) version 0.0.1 "
}

error() {
	ink red "$1";echo
}

need() {
	error "Need '$1' to $2 the filetype."
}


convert() {
	local command=$1

	case $command in

		resize)
			shift
			_convert_resize $@
			;;

		*)
			error "Unknown the command: $command"
			exit 1
			;;
	esac
}

_convert_resize() {
	while [ $# -gt 0 ];
	do
		case $1 in
			-w)
				local w=$2
				shift
				;;
			-h)
				local h=$2
				shift
				;;
			-o)
				local output=$2
				shift
				;;
			--help)
				cat <<EOF
Usage:
    $(basename ${0}) resize -w <width> [-h <height>] input -o output

EOF
				shift
				;;
			*)
				local input=$1
				;;
		esac
		shift
	done

	[ -n "$w" -a -n "$h" ] && error "cannot use the combination[-w, -h]";exit

	if is_osx; then
		if [ -n "$w" ]; then
			sips --resampleWidth $w $input --out  $output
		elif [ -n "$h" ]; then
			sips --resampleHeight $h $input --out  $output
		fi
	elif is_linux; then
		[ ! has convert ] && error "Need 'ImageMagick'"
		if [ -n "$w" ]; then
			convert -resize ${w}x -unsharp 2x1.4+0.5+0 -quality 100 $input $output
		elif [ -n "$h" ]; then
			convert -resize x${w} -unsharp 2x1.4+0.5+0 -quality 100 $input $output
		fi
	fi
}

while [ $# -gt 0 ];
do
    case $1 in

        --debug|-d)
            set -x
        ;;

        --help|-h)
			usage
			exit
        ;;

        --version|-v)
			version
			exit
        ;;

        *)
			convert $@
			exit
        ;;
    esac
    shift
done


