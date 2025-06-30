#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TODAY=$(date "+%a %b %d %Y")

while read -r line; do
    HOLIDAY=$(echo "$line" | awk '{print $1, $2, $3, $6}')
    if [[ "$TODAY" == "$HOLIDAY" ]]; then
        echo "[INFO] Today ($TODAY) is a Red. Process stopped."
        exit 0
    fi
done < "$SCRIPT_DIR/year.am"

echo "[INFO] Today ($TODAY) is a Black. Running system.sh..."
bash "$SCRIPT_DIR/system.sh"
