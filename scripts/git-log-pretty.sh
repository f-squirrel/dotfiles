#!/usr/bin/env bash
# Pretty git log with conventional commit type coloring.
# Types are colored: feat=green, fix=red, refactor=magenta, chore=blue,
# docs=cyan, ci/test=yellow, perf=red, build=blue, style=cyan.
git log --color=never --date=format:'%Y-%m-%d %H:%M' \
  --format='%h %s%d|%an|%ad' "$@" | \
awk -F'|' '{
  hash = substr($1, 1, index($1, " ") - 1)
  rest = substr($1, index($1, " ") + 1)
  author = $2
  date = $3

  type_color = ""
  if (rest ~ /^feat/)         type_color = "\033[32m"
  else if (rest ~ /^fix/)     type_color = "\033[31m"
  else if (rest ~ /^refactor/) type_color = "\033[35m"
  else if (rest ~ /^chore/)   type_color = "\033[34m"
  else if (rest ~ /^docs/)    type_color = "\033[36m"
  else if (rest ~ /^ci/)      type_color = "\033[33m"
  else if (rest ~ /^test/)    type_color = "\033[33m"
  else if (rest ~ /^perf/)    type_color = "\033[31m"
  else if (rest ~ /^build/)   type_color = "\033[34m"
  else if (rest ~ /^style/)   type_color = "\033[36m"

  if (match(rest, /^[a-z]+(\([^)]*\))?!?:/)) {
    prefix = substr(rest, RSTART, RLENGTH)
    msg = substr(rest, RSTART + RLENGTH)
    printf "\033[33m%s\033[0m %s%s\033[0m%s \033[2;32m— %s \033[2;34m%s\033[0m\n", hash, type_color, prefix, msg, author, date
  } else {
    printf "\033[33m%s\033[0m %s \033[2;32m— %s \033[2;34m%s\033[0m\n", hash, rest, author, date
  }
}'
