#!/bin/bash
# Paulo Henrique de Moura
# Para tornar executável: chmod +x moodle.sh
# Uso: ./moodle.sh diretório/de/destino arquivo.zip
# Descrição: descompacta o 'arquivo.zip' em 'diretório/de/destino/' e renomeia os arquivos com o RA de cada estudante.

[ -d "$1" ] && unzip "$2" -d "$1" && cd "$1" &&
# 
for file in *
do
	 mv "$file" "$(echo "${file%%_*}"|sed 's/[^0-9]//g').${file##*.}"
done
