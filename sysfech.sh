#!/usr/bin/env bash

info_labels=(
  'CPU'
  'Memory'
)

set_max_len() {
  local len
  for len in "$@"; do
    (( ${#len} > MAX_LEN )) && MAX_LEN=${#len}
  done
}

print_info() {
  printf "%-${MAX_LEN}s : %s\n" "${info_labels[$1]}" "$2"
}

print_cpu() {
  while read -r; do
    case "$REPLY" in
      model\ name*) cpumod=${REPLY#*:} ;;
      cpu\ cores* ) cpucores=${REPLY#*:}; break ;;
    esac
  done < /proc/cpuinfo

  print_info $1 "$cpumod $cpucores"
}

print_v() {
  print_info $1 "vase"
}

print_cpu cpu
