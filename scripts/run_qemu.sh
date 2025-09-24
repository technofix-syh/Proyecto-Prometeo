#!/bin/bash

# Script para ejecutar el kernel en QEMU

BUILD_DIR="build"
ISO_FILE="${BUILD_DIR}/prometeo.iso"

if [ ! -f "$ISO_FILE" ]; then
    echo "Error: No se encontró la imagen ISO. Ejecuta ./scripts/build.sh primero."
    exit 1
fi

echo "Iniciando Proyecto Prometeo en QEMU..."

QEMU_ARGS="
    -cdrom ${ISO_FILE}
    -m 512M
    -serial stdio
    -monitor telnet:localhost:1235,server,nowait
"

# Verificar si estamos en Linux y KVM está disponible
if [ "$(uname)" = "Linux" ] && [ -e /dev/kvm ]; then
    QEMU_ARGS="-enable-kvm ${QEMU_ARGS}"
    echo "Usando KVM para aceleración"
fi

qemu-system-x86_64 ${QEMU_ARGS}
