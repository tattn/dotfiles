. $DOTPATH/etc/utils.sh

function usage {
    cat <<EOF
Usage:
    $(basename ${0}) [command] [<options>]

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

parse_filepath() {
	filepath=$1
	name="${filepath%.*}"
	ext=${filepath##*.}
}

unpack() {
	parse_filepath $1

	case $ext in

		zip)
			if has unzip; then unzip $filepath
			else need "unzip" unpack
			fi
			;;

		gz)
			if has gunzip; then gunzip $filepath
			elif has gzip; then gzip -d $filepath
			else need "gunzip or gzip" unpack
			fi
			;;

		Z)
			if has gunzip; then gunzip $filepath
			elif has uncompress; then uncompress $filepath
			else need "gunzip or uncompress" unpack
			fi
			;;

		bz2)
			if has bzip2; then bzip2 -d $filepath
			elif has bunzip2; then bunzip2 $filepath
			else need "bzip2 or bugzip2" unpack
			fi
			;;

		tar.gz|tgz)
			if has tar; then tar -zxf $filepath
			else need tar unpack
			fi
			;;

		tar.Z|taz)
			if has tar; then tar -Zxf $filepath
			else need tar unpack
			fi
			;;

		.tar.bz2|.tbz2)
			if has tar; then tar -jxf $filepath
			else need tar unpack
			fi
			;;

		*)
			error "Unknown an extension: $ext"
			exit 1
			;;
	esac
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
			unpack $1
        ;;
    esac
    shift
done

if [ -z "$filepath" ]; then
	error "Need a filepath"
	usage
	exit
fi


