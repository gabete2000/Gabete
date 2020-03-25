#!/bin/bash
nom_dir=$(stat -c %n,%Y $HOME/bin??? 2>1)
if [ $? -eq 1 ];
then
	name=$(mktemp -d "$HOME/binXXX")
	echo "Se ha creado el directorio "${name}""
else
	num=0;
	for line in ${nom_dir}; do
		numAux=$(echo "${line}" | cut -d ',' -f2 )
		if [ ${numAux} -gt ${num} ]; 
		then
			num=${numAux}
			name=$(echo "${line}" | cut -d ',' -f1)
		fi
	done
fi
echo "Directorio destino de copia: "${name}""
exec_file=$(find -maxdepth 1 -mindepth 1 -executable -type f)
count=0
for file in ${exec_file}; do
	cp ${file} "${name}"
	echo ""${file}" ha sido copiado a "${name}""
	count=$(expr $count + 1)
done
if [ ${count} -eq 0 ]
then
	echo "No se ha copiado ningun archivo"
else
	echo "Se han copiado $count archivos"
fi
	
