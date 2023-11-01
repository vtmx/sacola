#!/usr/bin/env bash

cpf=$(tr -d '[.\-\ ]' <<< '134.567.890-12')
n="${cpf:0:8}"
o="${cpf:8:1}"

sede=$(case $o in
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

for (( pos=0; pos<=${#n}-1; pos++ )); do
  prod=$(( (pos+1) * ${cpf:pos:1} ))
  let sum+=$(( (pos+1) * ${cpf:pos:1} ))
  echo "$((pos+1)) * ${cpf:pos:1} = $prod"
done
echo "  SUM = $sum"

echo -e "\n cpf: $cpf
 fmt: $cpf
   n: $n
   o: $o
sede: $sede"
