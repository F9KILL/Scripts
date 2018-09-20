#!/bin/bash

# =========================================================
# Autor: Hugo Torres
# Data: 19/09/2018
# Descrição: Script para fazer Parsing em sites
# =========================================================

if [ "$1" == "" ]; then
	echo
	echo "Curso Pentest Profissional - DESEC Security"
	echo "Exemplo de uso: $0 www.site.com.br"
	echo
else
	# -----------------------------------------------------------
	# Fazendo download do site informado e aplicando filtros
	# para encontrar links.
	# -----------------------------------------------------------

	rm .f* index.html .temp &> /dev/null

	wget -q $1

	grep "href=" index.html > .f1

	sed -i 's/ /\n/g' .f1
	sed -i 's/</\n/g' .f1
	sed -i 's/>/\n/g' .f1

	grep "href=" .f1 > .f2

	sed -i 's/"/\n/g' .f2
	sed -i "s/'/\n/g" .f2
	sed -i 's/href=/\n/g' .f2
	sed -i 's/\/\//\n/g' .f2
	sed -i 's/http:/\n/g' .f2
	sed -i 's/https:/\n/g' .f2

	#grep "\." .f2 | sort | uniq > caminho_completo_$1.txt
	grep "\." .f2 | sort | uniq > .f3

	sed -i 's/\//\n/g' .f3
	sed -i 's/{/\n/g' .f3
	sed -i 's/}/\n/g' .f3
	sed -i 's/#/\n/g' .f3
	sed -i 's/%/\n/g' .f3
	sed -i 's/\,/\n/g' .f3
	sed -i 's/)/\n/g' .f3
	sed -i 's/(/\n/g' .f3
	sed -i 's/=/\n/g' .f3
	sed -i 's/\[/\n/g' .f3
	sed -i 's/\]/\n/g' .f3
	sed -i 's/|/\n/g' .f3
	sed -i 's/+/\n/g' .f3
	sed -i 's/-/\n/g' .f3
	sed -i 's/?/\n/g' .f3


	grep "\." .f3 | sort | uniq > .temp

	rm .f* index.html

	echo
	echo "==========================================================="
	echo " Links encontrados"
	echo "==========================================================="
	echo

	for host in $(cat .temp);do
		echo $host
	done

	# -----------------------------------------------------------
	# Verificando se os links estão ativos.
	# -----------------------------------------------------------

	echo
	echo "==========================================================="
	echo " Links ativos"
	echo "==========================================================="
	echo

	for host in $(cat .temp);do
		host $host 2> /dev/null | grep "has address"
	done
	echo

	rm .temp
fi
