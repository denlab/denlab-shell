#!/usr/bin/env bash
set -euox pipefail
IFS=$'\n\t'

new.sh() {
    : ${1? "

Usage: $FUNCNAME <scriptname>

"}
    local script="$1"
    if [[ -f "$script" ]]; then
        echo -e $"\nERROR! $script already exists!\n"
        return 1
    fi
    touch "$script"
    chmod +x "$script"
    local main="$script"".main"
    {
        cat <<'EOF'
#!/usr/bin/env bash
set -euox pipefail
IFS=$'\n\t'

. "$(dirname $(readlink -f $0))/util.sh"

EOF
        cat <<EOF
$main() {
  echo "\$FUNCNAME(\$@)"
}

[ "\$0" == "\$BASH_SOURCE" ] && $main "\$@"
EOF
    } > "$script"
}

new.sh "$@"
