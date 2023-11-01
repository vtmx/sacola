#!/usr/bin/env bash

cpf=$(tr -d '[.\-\ ]' <<< '987.654.321-00')
cpfnum="${cpf::9}"
dv="${cpf:9:2}"

sede=$(case "${cpf:8:1}" in
  1) echo Brasília ;;
  2) echo Belém ;;
  3) echo Fortaleza ;;
  4) echo Recife ;;
  5) echo Salvador ;;
  6) echo Belo Horizonte ;;
  7) echo Rio de Janeiro ;;
  8) echo São Paulo ;;
  9) echo Curitiba ;;
  0) echo Porto Alegre ;;
  *) echo Sede não existe; exit 1 ;;
esac)

for (( i=10; i>=2; i-- )); do
  prod=$(( ${cpfnum:pos:1} * i ))
  let sum+=$(( ${cpfnum:pos:1} * i ))
  (( pos++ ))
(( sum % 11 < 2)) && dv1=0 || dv1=$(( 11 - sum % 11))
done

cpfnum=$cpfnum$dv1
pos=0
sum=0

for (( i=11; i>=2; i-- )); do
  prod=$(( ${cpfnum:pos:1} * i ))
  let sum+=$(( ${cpfnum:pos:1} * i ))
  (( pos++ ))
done
(( sum % 11 < 2 )) && dv2=0 || dv2=$(( 11 - sum % 11))

echo -n " cpf: $cpf = "; (( $dv == $dv1$dv2 )) && echo -e "\033[0;32mválido\033[0m" || echo -e "\033[0;31minválido\033[0m"
echo "sede: $sede"
