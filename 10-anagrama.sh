#!/usr/bin/env bash

# str1='roma'
# str2='omor' 

while true; do
  clear
  read -p 'palavra 1: ' str1
  read -p 'palavra 2: ' str2
  echo

  # Verifica se a quantidade de palavras é igual
  [[ ${#str1} != ${#str2} ]] && {
    read -p 'erro: quantidade de palavras diferentes'
    continue
  }
  break
done

# Loop pela primeira palavra
for ((i=1; i<=${#str1}; i++)) do
  echo -en "${str1:$((i-1)):1}\n"

  # Loop pela segunda palavra
  for ((n=1; n<=${#str2}; n++)) do
    if [[ ${str1:$((i-1)):1} == ${str2:$((n-1)):1} ]]; then
      char=${char}1
      echo -en "${str1:$((i-1)):1} --o-- ${str2:$((n-1)):1}\n"
    else
      char=${char}0
      echo -en "${str1:$((i-1)):1} --x-- ${str2:$((n-1)):1}\n"
    fi
  done

  # Exibe cobinação
  echo $char

  # Verifica se existe algum caracter que não combinou
  if [[ ! $char =~ '1' ]]; then
    error='true'
  fi

  # Zera char
  char=""
  echo
done

echo -en "Resposta: "

# Verifica se a variável erro existe
if [[ $error ]]; then
  echo "Não é anagrama"
else
  echo "Anagrama"
fi
