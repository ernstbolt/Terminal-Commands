#!/usr/bin/env bash

export TERM=xterm-256color

FILE="/mnt/c/Users/abc/Les-week-11-Kubernetes-Orchestratie/Demo-week-11.md"


CHOICE=$(
  awk '
    BEGIN { RS="---"; ORS="" }
    {
      gsub(/^\n+|\n+$/, "", $0)
      if ($0 == "") next

      n++
      split($0, lines, "\n")
      title = lines[1]
      sub(/^#[[:space:]]*/, "", title)

      printf "%02d\t%s\n", n, title
    }
  ' "$FILE" | fzf \
      --no-sort \
      --layout=reverse \
      --delimiter=$'\t' \
      --with-nth=2 \
      --preview "
        awk -v target={1} '
          BEGIN { RS=\"---\" }
          {
            gsub(/^\n+|\n+$/, \"\", \$0)
            if (\$0 == \"\") next
            i++
            if (i == target) {
              print \$0
              exit
            }
          }
        ' \"$FILE\" | glow -s dark -
      " \
      --preview-window=right:70%:wrap
)

[ -z "$CHOICE" ] && exit 0

INDEX=$(printf '%s' "$CHOICE" | cut -f1)

BLOCK=$(
  awk -v target="$INDEX" '
    BEGIN { RS="---" }
    {
      gsub(/^\n+|\n+$/, "", $0)
      if ($0 == "") next
      i++
      if (i == target) {
        print $0
        exit
      }
    }
  ' "$FILE"
)

CMD=$(printf '%s\n' "$BLOCK" | tail -n 1)

eval "$CMD"


