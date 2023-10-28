#!/bin/bash
(( $# == 3 )) || {
    echo "Uso: $0   " >&2
    exit 1
}
declare -c Parm     # Param sempre estará capitalizada
for Parm            # Param assume cada um dos parâmetros passados
do 
    case $Parm in
        Preto)    Resistor+=0;;
        Marrom)   Resistor+=1;;
        Vermelho) Resistor+=2;;
        Laranja)  Resistor+=3;;
        Amarelo)  Resistor+=4;;
        Verde)    Resistor+=5;;
        Azul)     Resistor+=6;;
        Violeta)  Resistor+=7;;
        Cinza)    Resistor+=8;;
        Branco)   Resistor+=9;;
        *) echo Cor inválida >&2
           exit 1;;
    esac
done
Label=${Resistor:2:1}        # Fica a última cor, a que define a potência de 10
Resistor=10#${Resistor:0: -1}# 10# - Indica valor está na base 10
let Resistor*=10**Label
Zeros=${Resistor//[1-9]/}    # Exclui os algarísmos != 0
Unid=${#Zeros}               # Unid recebe a qtd de zeros
let Unid/=3                  # Unid recebe a qtd de grupos de 3 zeros
let Resistor/=1000**Unid     # Tira os grupos de 3 zeros do final
case $Unid in
    0) Resistor+=" ohms";;
    1) Resistor+=" kiloohms";;
    2) Resistor+=" megaohms";;
    3) Resistor+=" gigaohms";;
esac
echo $Resistor
