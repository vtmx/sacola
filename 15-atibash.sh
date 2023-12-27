#!/usr/bin/env bash

# Foreground azul
tput setaf 4;

# Recebe a palavra
[[ -t 0 && $1 ]] && word=$1 || read -p 'Palavra: ' word

# Verifica se argumento existe
[[ -z $word ]] && { echo 'erro: Precisa de pelo menos uma palavra.' >&2; exit 1; }

# Recebe alfabeto ordenado
alfao=$(echo {a..z})

# Recebe alfabeto invertido
alfai=$(echo {z..a})

# Recebe palavra codificada
coded=$(tr ${alfao// /} ${alfai// /} <<< ${word// /})

# Loop para adicionar espaço a partir da quarta palavra
for ((i=0; i<=${#coded}; i++)); do
  ((i != 0 && i % 4 == 0)) && result+=' '
  result+="${coded:i:1}"
done

# Exibe resultado
tput setaf 1; echo " Codigo: $result"

# Reseta tput
tput sgr0
