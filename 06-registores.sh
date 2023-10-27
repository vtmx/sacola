#!/usr/bin/env bash

[[ $@ ]] || { echo "erro: necessário 3 argumentos" >&2; exit 1; }

calc_faixa() {
  case $1 in
    preto)    echo 0 ;;
    marron)   echo 1 ;;
    vermelho) echo 2 ;;
    laranja)  echo 3 ;;
    amarelo)  echo 4 ;;
    verde)    echo 5 ;;
    azul)     echo 6 ;;
    violeta)  echo 7 ;;
    cinza)    echo 8 ;;
    branco)   echo 9 ;;
  esac
}

calc_mult() {
  case $1 in
    preto)    echo $((10**0)) ;;
    marron)   echo $((10**1)) ;;
    vermelho) echo $((10**2)) ;;
    laranja)  echo $((10**3)) ;;
    amarelo)  echo $((10**4)) ;;
    verde)    echo $((10**5)) ;;
    azul)     echo $((10**6)) ;;
    violeta)  echo $((10**7)) ;;
    cinza)    echo $((10**8)) ;;
    branco)   echo $((10**9)) ;;
  esac
}

format_result() {
  (($1 % 10**3 == 0)) && echo -n "$(($1 / 10**3)) kilo"
  (($1 % 10**4 == 0)) && echo -n "$(($1 / 10**4)) mega"
  (($1 % 10**5 == 0)) && echo -n "$(($1 / 10**5)) giga"
}

faixa1=$(calc_faixa $1)
faixa2=$(calc_faixa $2)
mult=$(calc_mult $3)
result=$(($faixa1$faixa2 * $mult))
fresult=$(format_result $result)

# Print format result or result
[[ $fresult ]] && echo "${fresult} omhs" || echo "${result} omhs"
