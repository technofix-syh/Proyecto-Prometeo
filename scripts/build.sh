#!/bin/bash

# Script de construcción del Proyecto Prometeo
set -e

echo "=== Proyecto Prometeo - Build System ==="

# Configuración
BUILD_DIR="build"
ISO_DIR="${BUILD_DIR}/iso"
KERNEL_NAME="prometeo-kernel"

# Crear directorios de build
mkdir -p ${BUILD_DIR} ${ISO_DIR}/boot/grub

echo "Compilando objetos..."

# Ensamblar archivos .asm
nasm -f elf64 src/boot/multiboot2.asm -o ${BUILD_DIR}/multiboot2.o
nasm -f elf64 src/boot/boot.asm -o ${BUILD_DIR}/boot.o

# Compilar código C
gcc -c src/kernel/main.c -o ${BUILD_DIR}/main.o -ffreestanding -nostdlib -I src/kernel/include -I src/arch/x86_64/include
gcc -c src/kernel/printk.c -o ${BUILD_DIR}/printk.o -ffreestanding -nostdlib -I src/kernel/include
gcc -c src/kernel/panic.c -o ${BUILD_DIR}/panic.o -ffreestanding -nostdlib -I src/kernel/include
gcc -c src/arch/x86_64/cpu.c -o ${BUILD_DIR}/cpu.o -ffreestanding -nostdlib -I src/arch/x86_64/include
gcc -c src/arch/x86_64/memory.c -o ${BUILD_DIR}/memory.o -ffreestanding -nostdlib -I src/arch/x86_64/include
gcc -c src/lib/string.c -o ${BUILD_DIR}/string.o -ffreestanding -nostdlib -I src/lib

echo "Enlazando kernel..."

# Linker
ld -n -T src/boot/linker.ld -o ${BUILD_DIR}/${KERNEL_NAME}.elf \
    ${BUILD_DIR}/multiboot2.o \
    ${BUILD_DIR}/boot.o \
    ${BUILD_DIR}/main.o \
    ${BUILD_DIR}/printk.o \
    ${BUILD_DIR}/panic.o \
    ${BUILD_DIR}/cpu.o \
    ${BUILD_DIR}/memory.o \
    ${BUILD_DIR}/string.o

echo "Creando imagen ISO..."

# Crear estructura para ISO
cp ${BUILD_DIR}/${KERNEL_NAME}.elf ${ISO_DIR}/boot/

# Configurar GRUB
cat > ${ISO_DIR}/boot/grub/grub.cfg << GRUB_EOF
menuentry "Proyecto Prometeo" {
    multiboot2 /boot/prometeo-kernel.elf
    boot
}
GRUB_EOF

# Crear ISO booteable
grub-mkrescue -o ${BUILD_DIR}/prometeo.iso ${ISO_DIR}

echo "Build completado:"
echo "  - Kernel: ${BUILD_DIR}/${KERNEL_NAME}.elf"
echo "  - ISO: ${BUILD_DIR}/prometeo.iso"
