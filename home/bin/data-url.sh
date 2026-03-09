#!/bin/bash

set -euo pipefail

FILE=${1:?specify a file}

echo -n "data:image/png;base64,"
convert "$FILE" -resize 48x48\> png:- | pngquant - | base64 -w0
echo
