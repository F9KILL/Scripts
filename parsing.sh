#!/usr/bin/env bash

# ==============================================================================
# Autor: Hugo Torres
# Data: 19/09/2018
#
# Descrição: Script para fazer Parsing em sites
# ==============================================================================

if [ "$1" == "" ]; then
    echo "                      _"
    echo "   ___  ___ ________ (_)__  ___ _"
    echo "  / _ \/ _ \`/ __(_-</ / _ \/ _ \`/"
    echo " / .__/\_,_/_/ /___/_/_//_/\_, /"
    echo "/_/                       /___/"
    echo
    echo "Exemplo de uso: $0 www.site.com.br"
    echo
else
    # ==========================================================================
    # Constantes
    # ==========================================================================
    RED='\033[31;1m'
    GREEN='\033[32;1m'
    BLUE='\033[34;2m'
    YELLOW='\033[33;1m'
    WHITE='\033[39;1m'
    BLACK='\033[38;1m'
    END='\033[m'

    # ==========================================================================
    # Fazendo download do site informado.
    # ==========================================================================
    printf "\n${RED}[+] Limpando arquivos anteriores...${END}"
    rm -rf /tmp/1 &>/dev/null

    printf "\n${RED}[+] Fazendo download da página...${END}\n\n"
    mkdir /tmp/1 && cd /tmp/1 && wget -q -c --show-progress $1

    # ==========================================================================
    # Aplicando filtros.   
    # ==========================================================================
    grep "href" index.html > .f1
    grep "http" index.html >> .f1
    grep "ftp" index.html >> .f1

    sed -i 's/ /\n/g' .f1
    sed -i 's/</\n/g' .f1
    sed -i 's/>/\n/g' .f1
    sed -i 's/;/\n/' .f1
    sed -i 's/{/\n/g' .f1
    sed -i 's/}/\n/g' .f1
    sed -i 's/)/\n/g' .f1
    sed -i 's/(/\n/g' .f1
    sed -i 's/\[/\n/g' .f1
    sed -i 's/\]/\n/g' .f1
    sed -i 's/|/\n/g' .f1
    sed -i 's/#/\n/g' .f1
    sed -i 's/%/\n/g' .f1
    sed -i 's/+/\n/g' .f1
    sed -i 's/-/\n/g' .f1
    sed -i 's/?/\n/g' .f1
    sed -i 's/&/\n/g' .f1
    sed -i 's/\,/\n/g' .f1
    
    grep "href" .f1 > .f2
    grep "http" .f1 >> .f2
    grep "ftp" .f1 >> .f2

    sed -i 's/"/\n/g' .f2
    sed -i "s/'/\n/g" .f2
    sed -i "s/=/\n/g" .f2
    sed -i 's/http:/\n/g' .f2
    sed -i 's/https:/\n/g' .f2
    sed -i 's/\//\n/g' .f2
    sed -i 's/\\/\n/g' .f2
    sed -i 's/\.css/\n/g' .f2
    sed -i 's/\.js/\n/g' .f2
    sed -i 's/\.href/\n/g' .f2
    sed -i 's/\.png/\n/g' .f2
    sed -i 's/\.gif/\n/g' .f2
    sed -i 's/\.jpg/\n/g' .f2
    sed -i 's/\.jpeg/\n/g' .f2
    sed -i 's/\.bmp/\n/g' .f2
    sed -i 's/\.svg/\n/g' .f2
    sed -i 's/\.ttf/\n/g' .f2
   
    grep "\." .f2 | sort | uniq > .temp
    
    # ==========================================================================
    # Mostrando links encontrados
    # ==========================================================================

    printf "\n${GREEN}====================================================================================${END}\n"
    printf "${GREEN}                             Links encontrados${END}"
    printf "\n${GREEN}====================================================================================${END}\n\n"

    while read host;do
        echo $host
    done < .temp

    # ==========================================================================
    # Verificando se os links estão ativos.
    # ==========================================================================

    printf "\n${GREEN}====================================================================================${END}\n"
    printf "${GREEN}                                Links ativos${END}"
    printf "\n${GREEN}====================================================================================${END}\n\n"

    while read host;do
        host $host 2> /dev/null | grep "has address" | sed "s/has address/\t\t\t/"
    done < .temp
fi
