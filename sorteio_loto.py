#!/usr/bin/env python

"""
Programa para verificar o número de acertos de jogos da loteria.
Necessário um arquivo de texto com o nome "jogos" contendo os jogos que 
deseja conferir, no mesmo local do programa. O arquivo deve ter 
a seguinte sintaxe:

<Nome do jogo> <números>

exemplo:

Jogo01 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15
Jogo02 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15
Jogo03 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15
-------------------------------------------------------------------

Para utilizar o programa, é necessário informar os números do sorteio.
exemplo:

python sorteio_loto.py 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15

"""

LOTO = 15

import sys

try:
	arquivo = open('jogos', 'r')
except:
	print('\nOcorreu um erro na abertura do arquivo!\n')

jogos = arquivo.readlines()
acertos = 0

for jogo in jogos:
	# Loop do resultado
	for x in  range(LOTO):
		# Loop dos jogos
		for y in range(LOTO):
			if sys.argv[x+1] == jogo.split()[y+1]:
				acertos += 1

	print('%s ----> [%s] acertos' %(jogo.split()[0], acertos))
	acertos = 0
