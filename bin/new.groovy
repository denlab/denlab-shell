#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

main() {
    : ${1? "
Usage: $0 <scriptname>
"}
    local script="$1"
    script+=".groovy"
    if [[ -f "$script" ]]
    then
        echo -e $"\nERROR! $script already exists!\n"
        return 1
    fi
    touch "$script"
    chmod +x "$script"
    {
        cat <<EOF
#!/usr/bin/env groovy

println "hello from $script !"

EOF
    } > "$script"
    echo "wrote script: $(readlink -f $script)"
}

main "$@"
