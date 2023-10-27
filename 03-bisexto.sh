#!/usr/bin/env bash

function bisexto() {
  echo -n "Ano: $1 - "

  if [[ $((year % 4)) -eq 0 && $((year % 100)) -ne 0 ]]; then
    echo "bisexto"
  else
    echo "não é bisexto"
  fi
}

year=5
bisexto $year

