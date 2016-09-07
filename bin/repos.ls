#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

REPOS_HOME=~/repos/

find $REPOS_HOME -name .git -type d -exec dirname {} \;
