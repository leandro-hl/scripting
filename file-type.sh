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
LOOKUP=$last

# si es directorio buscamos en todos sus hijos
if [[ "$DIRECTORIO" -eq 1  ]]; then
    echo "Nombre directorio: $LOOKUP";
    grilla="$archivo $EXTENSION $PERMISOS"
else
    echo "Nombre: $LOOKUP"
    grilla="$EXTENSION $PERMISOS"
fi

[[ "$RECURSIVO" -eq 1  ]] && params+=(-R)
[[ "$ORDENADO" -eq 1  ]] && params+=(--sort)

for archivo in `ls -1 "${params[@]}" $LOOKUP`; do
    EXTENSION= file $archivo | awk '{$1=""; printf "%s%s", substr($0,1,10), "\t"}'
    PERMISOS= ls -l $archivo | awk '{for(x=3; x<= 5; x++){ printf "%s%s", substr($x,1,10), "\t"}}'

    echo $grilla
done


echo "DIR ${DIRECTORIO} REC ${RECURSIVO} ORD ${ORDENADO} ${ARCHIVO}"