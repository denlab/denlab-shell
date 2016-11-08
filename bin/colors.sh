#!/bin/bash 

# BEGIN COLORS ################################################################

colorize() {
    declare -A colorsCodes=(
        [red]='0;31'
        [green]='0;32'
        [blue]='0;34'
        [yellow]='0;33'
        [none]='0'
    )
    local color="${1}"
    local code="${colorsCodes[$color]}"
    local noneCode="${colorsCodes[none]}"
    echo -en '\033['${code}'m'
    cat
    echo -en '\033['${noneCode}'m'
}

echoErr() {
    echo "$@" | colorize red 1>&2
}

echoInfo() {
    if $echoInfoEnabled; then
        indent="$(jq -r -n "\"  \" * $BASH_SUBSHELL")"
        echo -e "$indent$@" | colorize blue  1>&2
    fi
}

echoNotice() {
    echo -e "$@" | colorize yellow 1>&2
}

echoErrNoColor() {
    echo "$@" | colorize red 1>&2
}

colorize_test() {
    eval $_f
    echo "red" | colorize red
    echo "blue" | colorize blue
    echo "yellow" | colorize yellow
    echo "green" | colorize green
}

debug() {
    if "$DEBUG"; then
        echoNotice "$@"
    fi
}

declare echoInfoEnabled=false

echoInfoOn() {
    echoInfoEnabled=true
}

echoInfoOff() {
    echoInfoEnabled=false
}


repeatStr() {
    local str="$1" n="$2"
    yes "$str" | head -n "$n" | tr -d '\n'
}

echoTitle() {
    local title="$*"
    title="* $title"
    local titleSize=${#title}
    local high=$(repeatStr '=' $titleSize)
    echoInfo
    echoInfo "$title"
    echoInfo "$high"
    echoInfo
}

fnExists() {
    local fnName="$1"
    declare -F | cut -d' ' -f 3 | grep -q "$fnName"
}


off() {
    declare desc="disable functions"
}

# END COLORS ################################################################
