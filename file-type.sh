#!/bin/bash

# Dado un nombre de archivo indica que tipo es.
# Agregar manejo de n paginas.

DIRECTORIO=0
RECURSIVO=0
ORDENADO=0

usage() {
cat << EOF
Version: V1
Usage: $0 [-d directorio] [-r recursivo] [-t orden] nombre_archivo
-d: directorio
-r: recursivo
-t: orden alfabetico
EOF
}

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
        v)
            #   Indica version y forma de uso
            usage
            exit 1;
            ;;
        *)
            #   Indica version y forma de uso
            usage
            exit 1;
            ;;
    esac
done

for last; do true; done
ARCHIVO=$last

echo "    TIPO DE ARCHIVO    USR DUEÑO    GRP DUEÑO    TAMAÑO    LINKS"

if [ "$DIRECTORIO" -eq 1 ]; then
    ls -l $ARCHIVO | awk '$0="    "$3"    "$4"    "'
fi

echo "DIR ${DIRECTORIO} REC ${RECURSIVO} ORD ${ORDENADO} ${ARCHIVO}"