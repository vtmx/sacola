#!/usr/bin/env bash
 
sem_espaco() {
  local cad1=$1
  local cad2=$2

  # Verifica se as cadeias possuem tamanhos iguais
  (( ${#cad1} != ${#cad2} )) && {
    echo "Cadeia de tamanhos diferentes" >&2
    exit 1
  }

  # Loop
  declare -i sum=0

  for ((i=1; i <= "${#cad1}"; i++)); do
    [[ ${cad1:$((i-1)):1} == ${cad2:$((i-1)):1} ]] && {
      sum+=1
    }
  done

  # Exibe a soma dos valores
  echo "Resposta sem espaço: $sum"
}

com_espaco() {
  local cad1=$1
  local cad2=$2

  # Verifica se as cadeias possuem tamanhos iguais
  (( ${#cad1} != ${#cad2} )) && {
    echo "Cadeia de tamanhos diferentes" >&2
    exit 1
  }

  # Loop
  declare -i sum=0

  for ((i=1; i <= "${#cad1}"; i++)); do
    [[ ${cad1:$((i-1)):1} == ${cad2:$((i-1)):1} && ${cad1:$((i-1)):1} != ' ' && ${cad2:$((i-1)):1} != ' ' ]] && {
      sum+=1
    }
  done

  # Exibe a soma dos valores
  echo "Resposta com espaço: $sum"
}

sem_espaco 'abcd' 'abcd'
com_espaco 'a b c d' 'a b c d'

