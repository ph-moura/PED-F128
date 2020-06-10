#!/bin/bash
# Paulo Henrique de Moura
# Para tornar executável: chmod +x notas.sh

echo "Entre com o nome do arquivo de notas:"
read file 
file="$(pwd)/$file"
echo "Lendo arquivo de notas '$file' ..."
a1=1
aluno=[]
while read -r line
do
	aluno[$(echo $line | awk -F ' ' '{print $1}')]="E"
done < $file 

[[ -f "${file%%.**}.backup" ]] &&
while read -r line
do
	aluno[$(echo $line | awk -F ' ' '{print $1}')]="$(echo $line | sed 's/.* //')"
done < ${file%%.*}.backup

echo "**************** Instruções **************"
echo "Digite o RA dos alunos '1' '2' e '3' e seu conceito"
echo "Exemplo:"
echo "1234 5678 9011 B"
echo "Caso o grupo tenha menos de 3 alunos, complete seu RA com '0'."
echo "Exemplo:"
echo "1234 0 0 A"
echo "Para encerrar digite 0 para o primeiro RA." 
echo "******************************************"

echo "Deseja continuar? (s/N)"
read option
[[ "$option" == "s" ]] &&
{
	while [ $a1 -ne 0 ] 
	do
		read a1 a2 a3 nota
		[[ $a1 -ne 0 ]] && aluno[$a1]=$nota && echo "$a1 $nota" >> "${file%%.*}.backup"
		[[ $a2 -ne 0 ]] && aluno[$a2]=$nota && echo "$a2 $nota" >> "${file%%.*}.backup"
		[[ $a3 -ne 0 ]] && aluno[$a3]=$nota && echo "$a3 $nota" >> "${file%%.*}.backup"
	done

	echo "Deseja gravar as alterações no arquivo? (s/N)"
	read option
	[[ "$option" == "s" ]] &&
	while read line
	do
		ra=`echo $line | awk -F ' ' '{print $1}'`
		sed -i "s/[[:blank:]]*$//; /^$ra/ s/$/ ${aluno[$ra]}/" $file
	done < $file &&
	rm  ${file%%.*}.backup
}
