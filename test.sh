#!/usr/bin/env bash

# Não está completamente certo, está aceitando letras depois do primeiro número, ex: 3df34
if [[ "$1" =~ ^[[:digit:]]{1,} && -z "$2" ]]; then
  case "$1" in
    *1*)
      echo Achei: 1;;&
    *2*)
      echo Achei: 2;;&
    *3*)
      echo Achei: 3;;&
    *4*)
      echo Achei: 4;;&
    *67*)
      echo Achei: 67;;&
  esac
else
  echo "erro: Aceita 1 parâmetro numérico"; exit 1
fi


