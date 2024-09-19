#!/bin/sh
set -euo pipefail

# jqコマンドが有るか?
command -v jq >/dev/null 2>&1 ||
  { echo >&2 "jq is required but it's not installed. Aborting."; exit 1; }

# 現在のパッケージのバージョン
NODE_RED_VERSION=$(jq -r .version package.json)
if ! echo "$NODE_RED_VERSION" | grep -Eq '^[0-9]+\.[0-9]+\.[0-9]+$'; then
  echo "Invalid version format: $NODE_RED_VERSION"
  exit 1
fi

FILE="data$(date -I)-${NODE_RED_VERSION}.tar.gz"
trap "rm -f ${FILE}" HUP INT QUIT TERM #bash ERR #KILLはトラップできない

tar cvfz ${FILE} data/
