#!/usr/bin/env bash

operacao() {
  [[ $1 && $2 && $3 && -z $4 ]] ||
    echo Escolha uma opção desejada, tipo: 3 + 3 >&2; return 1
}

operacao $@
