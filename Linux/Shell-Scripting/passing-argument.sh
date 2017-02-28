echo There are $# arguments to $0: $*
echo first argument: $1
echo second argument: $2
echo third argument: $3
echo here they are again: $@

function how_many {
	print "$# arguments were supplied."
}

how_many "$*"
how_many "$@"

