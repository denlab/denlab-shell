#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

echo "util.sh loading ..."

repeat() {
          local count="$1"
          set +e
          sedRep="$(yes '&' | head -n $count | tr -d '\n')"
          local rc=$?
          set -e
          if [[ $rc -ne 0 ]] && [[ $rc -ne 141 ]]; then
              return $rc
          fi
          sed "s/.*/$sedRep/g"
      }

util.main() {
  echo "$FUNCNAME($@)"
}

if [ "$0" == "$BASH_SOURCE" ]; then
    util.main "$@"
fi

