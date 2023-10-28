#!/usr/bin/env bash

operacao() {
  echo "Resultado: $(($@))"
}

operacao $@
