#!/bin/bash

# Dependencia para usar recursividad con glob.
shopt -s globstar

usage() {
cat << EOF
Version: V1
Usage: $0 [-d directorio] [-r recursivo] [-t orden] nombre_archivo
-d: directorio
-r: recursivo
-t: orden alfabetico
EOF
}


DIRECTORIO=0
RECURSIVO=0
ORDENADO=0

while getopts "drtv" o; do
    case "${o}" in                
        d)
            #   Directorio. Informar para todos los hijos
            DIRECTORIO=1
            ;;
        r)
            #   Realizarlo de forma recursiva
            RECURSIVO=1
            ;;
        t)
            #   Ordenar alfabeticamente
            ORDENADO=1
            ;;
        *)
            #   -v y otros ingresan aqui. Indica version y forma de uso
            usage
            exit 1;
            ;;
    esac
done

# Obtenemos el ultimo parametro ingresado (El nombre del archio o directorio)
for last; do true; done
LOOKUP=$last

# si es directorio buscamos en todos sus hijos
if [[ "$DIRECTORIO" -eq 1  ]]; then
    echo "Nombre directorio: $LOOKUP";
    echo "Nombre Archivo      Tipo    Usr Dueño   Grp Dueño   Tamaño"
else
    echo "Nombre: $LOOKUP"
    echo "Tipo Archivo    Usr Dueño   Grp Dueño   Tamaño"
fi

if [ "$DIRECTORIO" -eq 1 ] && [ "$RECURSIVO" -eq 1 ]; then
    #si el lookup es un directorio y es recursivo: $LOOKUP/**
    COMMAND="$LOOKUP/**"
elif [ "$DIRECTORIO" -eq 1 ] && [ "$RECURSIVO" -eq 0 ]; then
    #si el lookup es un directorio y no es recursivo $LOOKUP/*
    COMMAND="$LOOKUP/*"
elif [ "$DIRECTORIO" -eq 0 ] && [ "$RECURSIVO" -eq 1 ]; then
    #si el lookup no es un directorio y es recursivo: **/file
    COMMAND="**/$LOOKUP"
else
    #si el lookup no es un directorio y no es recursivo: file
    COMMAND="$LOOKUP"
fi

for archivo in $COMMAND; do
    EXTENSION= file $archivo | awk '{$1=""; printf "%s%s", substr($0,1,10), "\t"}'
    PERMISOS= ls -l $archivo | awk '{for(x=3; x<= 5; x++){ printf "%s%s", substr($x,1,10), "\t"}}'

    if [[ "$DIRECTORIO" -eq 1  ]]; then
        echo "$archivo $EXTENSION $PERMISOS"
    else
        echo "$EXTENSION $PERMISOS"
    fi
done