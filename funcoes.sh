#!/usr/bin/env bash

function Uso
{
        #  Dá msg de erro para stderr e aborta passando codigo de erro
        #+ Recebe como parâmtros: msg de erro e código de erro ($?)
    echo $0: "$1" >&2
    exit $2
}; export -f Uso

function Repete
{
        #  Repete um caractere um determinado número de vezes
        #+ Recebe:
        #+ Tamanho final da cadeia
        #+ e caractere a ser repetido
    local Var
    printf -v Var %$1s " "
    echo ${Var// /$2}
}; export -f Repete

function EncheEsq
{
        #  Preenche à esquerda com caractere especificado
        #+ Recebe:
        #+ Valor inicial da cadeia,
        #+ Tamanho final e char de preenchimento
    local Var
    local Cadeia=${1// /^}    # Trocando eventuais espaços preexistentes
    printf -v Var %$2s $Cadeia
    Var=${Var// /$3}
    echo "${Var//^/ }"        # Restaurando espaços anteriores
}; export -f EncheEsq

function EncheDir
{
        #  Preenche à direita com caractere especificado
        #+ Recebe:
        #+ Valor inicial da cadeia,
        #+ Tamanho final e char de preenchimento
    local Var
    local Cadeia=${1// /^}    # Trocando eventuais espaços preexistentes
    printf -v Var %-$2s $Cadeia
    Var=${Var// /$3}
    echo "${Var//^/ }"        # Restaurando espaços anteriores
}; export -f EncheDir

function DesenhaCaixa
{
        #  Desenha uma caixa
        #+     1o. parâmetro: Linha
        #+     2o. parâmetro: Coluna
        #+     3o. parâmetro: Altura
        #+     4o. parâmetro: Largura
    local i
    local Largura=$4
    printf -v Linha "%${Largura}s" ' '     # Cria $Largura espaços em $Linha
    printf -v Traco "\e(0\x71\e(B"         # Põe um traço semigráfico em $Traco
    tput cup $1 $2; printf "\e(0\x6c\e(B"  # Canto superior esquerdo
    echo -n ${Linha// /$Traco}             # Troca todos os espaços de $Linha por $Traco
    printf "\e(0\x6b\e(B\n"                # Canto superior direito
    for  ((i=1; i<=$3; i++))               # Construindo altura
    do
        tput cup $(($1+i)) $2 
        printf "\e(0\x78\e(B"               # Barra vertical esquerda
        printf %${Largura}s"\e(0\x78\e(B\n" # Barra vertical direita
    done
    printf -v linha "%${Largura}s" ' '
    printf -v traco "\e(0\x71\e(B"
    tput cup $(($1+i)) $2; printf "\e(0\x6d\e(B"
    echo -n ${Linha// /$Traco}             # Troca todos os espaços de $Linha por $Traco
    printf "\e(0\x6a\e(B\n"
}; export -f DesenhaCaixa

function DesenhaCaixaComTexto
{
        #  Desenha uma caixa
        #+     1o. parâmetro: Linha
        #+     2o. parâmetro: Coluna
        #+     3o. parâmetro: Texto que ficará na caixa
    local i
    local Texto=$(echo -e "$3")
    local Largura=$(( $(wc -L <<< "$Texto") + 2))   # wc -L da o tamanho da maior linha
    local Linhas                                    # Vetor que conterá as linhas (origem 1)
    for ((i=1; i<=$(wc -l <<< "$Texto"); i++))
    {
        Linhas[i]=$(head -$i <<< "$Texto" | tail -1)
    }
    printf -v Linha "%${Largura}s" ' '              # Cria $Largura espaços em $Linha
    printf -v Traco "\e(0\x71\e(B"                  # Põe um traço semigráfico em $Traco
    tput cup $1 $2; printf "\e(0\x6c\e(B"           # Canto superior esquerdo
    echo -n ${Linha// /$Traco}                      # Troca todos os espaços de $Linha por $Traco
    printf "\e(0\x6b\e(B\n"                         # Canto superior direito
    for  ((i=1; i<=$(wc -l <<< "$Texto"); i++))     # Construindo altura
    do
        tput cup $(($1+i)) $2
        printf "\e(0\x78\e(B ${Linhas[i]}"          # Barra vertical esquerda + texto
        tput cup $(($1+i)) $(($2 + Largura +1))
        printf "\e(0\x78\e(B"                       # Barra vertical direita
    done
    printf -v linha "%${Largura}s" ' '
    printf -v traco "\e(0\x71\e(B"
    tput cup $(($1+i)) $2; printf "\e(0\x6d\e(B"
    echo -n ${Linha// /$Traco}                      # Troca todos os espaços de $Linha por $Traco
    printf "\e(0\x6a\e(B\n"
}; export -f DesenhaCaixaComTexto

function Descomprime
{
        #  Recebe um arquivo comprimido e o descomprime
        #+ utilizando o utilitário adequado

    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)
                tar xvjf $1;;
            *.tar.gz)
                tar xvzf $1;;
            *.bz2)
                bunzip2 $1;;
            *.rar)
                unrar x $1;;
            *.gz)
                gunzip $1;;
            *.tar)
                tar xvf $1;;
            *.tbz2)
                tar xvjf $1;;
            *.tgz)
                tar xvzf $1;;
            *.zip)
                unzip $1;;
            *.Z)
                uncompress $1;;
            *.7z)
                7z x $1;;
            *)
                echo Não sei como descomprimir o arquivo '$1'
        esac
    else
        echo Não existe um arquivo regular chamado $1
    fi
}; export Descomprime

function EsqDir1
{
        #  Limpa a tela da esquerda para a direita
        #+ apagando linha a linha
    local Col Larg=$(tput cols)
    local Lin Alt=$(tput lines)
    tput civis
    for ((Col=0; Col<Larg; Col++))
    {
        for ((Lin=0; Lin<Alt; Lin++))
	{
	    tput cup $Lin $Col
	    tput ech 1
        }
    }
    tput home
    tput cnorm
}

function EsqDir2
{
        #  Limpa tela da esquerda para a direita
        #+ empurrando o texto.
    Alt=$(tput lines)
    Larg=$(tput cols)
    tput civis
    for ((Col=0; Col<$Larg; Col++))
    { 
        for ((Lin=0; Lin<$Alt; Lin++))
        {
            tput cup $Lin 0
            tput ich 1
        }
    }
    tput home
    tput cnorm
}

function DirEsq1
{
        #  Limpa a tela da direita para a esquerda
        #+ comendo o texto
    local Col Larg=$(tput cols)
    local Lin Alt=$(tput lines)
    tput civis
    for ((Conta=0; Conta<Larg; Conta++))
    {
        for ((Lin=0; Lin<Alt; Lin++))
    	{ 
    	    tput cup $Lin 0
    	    tput dch 1
    	}
    }
    tput cnorm
    tput home
}

function DirEsq2
{
        #  Limpa a tela da direita para a esquerda
        #+ comendo o texto
    local Col Larg=$(tput cols)
    local Lin Alt=$(tput lines)
    tput civis
    for ((Col=Larg; Col>=0; Col--))
    {
        for ((Lin=0; Lin<Alt; Lin++))
        {
            tput cup $Lin $Col
            tput dch 1
        }
    }
    tput cnorm
    tput home
}

function PosicaoCursor
{
        #  Devolve Linha Coluna da posição atual do cursor
    exec < /dev/tty
    local Pos Lin Col SttyVeio=$(stty -g)
    stty raw -echo min 0
                                     #  No meu sistema, a linha a seguir pode
                                     #+ ser substituída pela que está abaixo dela
    echo -en "\033[6n" > /dev/tty
    # tput u7 > /dev/tty             #  Qdo TERM=xterm (ou similares)
    IFS=';' read -r -d R -a Pos
    stty $SttyVeio
                                     #  Trocando de origem 1 para zero, adaptando
                                     #+ para fazer um: tput cup $Lin $Col
    Lin=$((${Pos[0]:2} - 1))         #  Excluindo o esc-[
    Col=$((${Pos[1]} - 1))
    echo "$Lin $Col"
}

function TabelaAscii
{
        #  Gera uma tabela com decimal e o ASCII correspondente
        #  Só para entender um printf octal, gera um ascii.
        #+ printf '\101\n' gera "A"
        #+ Então gero decimal, converto para octal e gero o ascii.
    local Num
    for ((Num=33; Num<127; Num++))
    do
        printf "%03d\t\\$(printf %03o $Num)\n" $Num # Experimente printf '\101\n' 
    done | columns -c5
}
  
