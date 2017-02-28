
wrappedProgram() {
    for var in "$@"
    do
        echo "$var"
    done
}


wrappedProgram "$@"

wrappedProgram "$*"

wrappedProgram $*

wrappedProgram $@
