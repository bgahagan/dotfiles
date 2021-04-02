#!/bin/bash

keyboard_buttons() {
  xset q | grep -E -o "(Num Lock|Caps Lock)\W+(on|off)" | awk '
    /on/  {printf ",{\"name\":\"%s\", \"color\":\"#00FF00\", \"full_text\":\"%s\"}", $1, substr($1,1,1)}
    /off/ {printf ",{\"name\":\"%s\", \"color\":\"#000000\", \"full_text\":\"%s\"}", $1, substr($1,1,1)}
  '
}

process() {
  # Skip verision header
  read -r line
  echo "$line"
  # Skip open of infinite array
  read -r line
  echo "$line"

  while read -r line; do
    #orig=$(echo -n "$line" | sed -E 's/^,?\[//;s/\]$//')
    echo -n "$line" | sed -E 's/\]$//'
    keyboard_buttons
    echo "]"
  done

}

i3status -c ~/.i3/i3status.conf | process
