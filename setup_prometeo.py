#!/usr/bin/env python3
"""
Script de configuración para el Proyecto Prometeo
Crea toda la estructura de archivos y directorios del kernel
"""

import os
import stat

def create_file(path, content):
    """Crea un archivo con el contenido especificado"""
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f"✅ Creado: {path}")

def make_executable(path):
    """Hace que un archivo sea ejecutable"""
    st = os.stat(path)
    os.chmod(path, st.st_mode | stat.S_IEXEC)

def main():
    print("🚀 Iniciando creación del Proyecto Prometeo...")
    
    # Crear estructura de directorios
    directories = [
        "src/boot",
        "src/kernel/include", 
        "src/arch/x86_64/include",
        "src/lib",
        "scripts"
    ]
    
    for directory in directories:
        os.makedirs(directory, exist_ok=True)
        print(f"📁 Creado: {directory}/")

    # Archivos en src/boot/
    create_file("src/boot/multiboot2.asm", """; Header Multiboot2 para bootloader
section .multiboot_header
header_start:
    dd 0xe85250d6                ; Magic number (Multiboot 2)
    dd 0                         ; Architecture 0 (x86_64)
    dd header_end - header_start ; Header length

    ; Checksum
    dd 0x100000000 - (0xe85250d6 + 0 + (header_end - header_start))

    ; Required end tag
    dw 0    ; Type
    dw 0    ; Flags
    dd 8    ; Size
header_end:
""")

    create_file("src/boot/boot.asm", """; Punto de entrada del kernel en assembler
section .text
global _start
extern kernel_main

_start:
    ; Establecer stack básico
    mov rsp, stack_top
    
    ; Verificar magic number de Multiboot2
    cmp eax, 0x36d76289
    jne .no_multiboot
    
    ; Llamar al kernel principal en C
    call kernel_main
    
.halt:
    hlt
    jmp .halt

.no_multiboot:
    mov al, '0'
    jmp .error

.error:
    ; Pantalla de error mínima (modo texto)
    mov dword [0xb8000], 0x4f524f45
    mov dword [0xb8004], 0x4f3a4f52
    mov dword [0xb8008], 0x4f204f20
    mov byte  [0xb800a], al
    hlt

section .bss
align 16
stack_bottom:
    resb 16384 ; 16KB stack
stack_top:
""")

    create_file("src/boot/linker.ld", """/* Script del linker para el kernel */
ENTRY(_start)

SECTIONS
{
    . = 1M;

    .boot :
    {
        /* Asegurar que el header multiboot esté al inicio */
        *(.multiboot_header)
    }

    .text :
    {
        *(.text)
    }

    .data :
    {
        *(.data)
    }

    .bss :
    {
        *(.bss)
    }
}
""")

    # Archivos en src/kernel/
    create_file("src/kernel/main.c", """/* Punto de entrada principal del kernel */
#include <kernel/printk.h>
#include <arch/x86_64/cpu.h>
#include <arch/x86_64/memory.h>

void kernel_main(void) 
{
    // Inicializar sistema de logging
    printk_init();
    
    printk("=== Proyecto Prometeo ===\\n");
    printk("Kernel booteado exitosamente!\\n");
    printk("Inicializando sistema...\\n");
    
    // Inicializar arquitectura x86_64
    x86_64_cpu_init();
    x86_64_memory_init();
    
    printk("Sistema inicializado. Entrando en loop principal...\\n");
    
    // Loop principal del kernel
    while (1) {
        asm volatile ("hlt");
    }
}
""")

    create_file("src/kernel/printk.c", """/* Sistema de logging básico para el kernel */
#include <kernel/printk.h>

// Driver básico de video (modo texto VGA)
static volatile char* video_memory = (volatile char*)0xb8000;
static int cursor_pos = 0;

void printk_init(void) 
{
    // Limpiar pantalla
    for (int i = 0; i < 80 * 25 * 2; i += 2) {
        video_memory[i] = ' ';
        video_memory[i + 1] = 0x07;  // Gris claro sobre negro
    }
    cursor_pos = 0;
}

void printk(const char* str) 
{
    while (*str) {
        if (*str == '\\n') {
            // Nueva línea: mover al inicio de la siguiente línea
            cursor_pos = ((cursor_pos / 160) + 1) * 160;
        } else {
            video_memory[cursor_pos] = *str;
            video_memory[cursor_pos + 1] = 0x07;
            cursor_pos += 2;
        }
        str++;
        
        // Scroll si llegamos al final de la pantalla
        if (cursor_pos >= 80 * 25 * 2) {
            // Por ahora, simplemente volvemos al inicio
            cursor_pos = 0;
        }
    }
}
""")

    create_file("src/kernel/panic.c", """/* Manejo de errores críticos del kernel */
#include <kernel/printk.h>

void panic(const char* message) 
{
    printk("*** KERNEL PANIC ***\\n");
    printk("Error: ");
    printk(message);
    printk("\\nSistema detenido.\\n");
    
    // Detener el sistema
    while (1) {
        asm volatile ("hlt");
    }
}
""")

    # Headers en src/kernel/include/
    create_file("src/kernel/include/printk.h", """#ifndef PRINTK_H
#define PRINTK_H

void printk_init(void);
void printk(const char* str);

#endif
""")

    create_file("src/kernel/include/kernel.h", """#ifndef KERNEL_H
#define KERNEL_H

// Definiciones generales del kernel
#define KERNEL_VERSION "0.1.0"
#define KERNEL_NAME "Prometeo"

#endif
""")

    # Archivos en src/arch/x86_64/
    create_file("src/arch/x86_64/cpu.c", """/* Inicialización básica de la CPU x86_64 */
#include <arch/x86_64/cpu.h>

void x86_64_cpu_init(void) 
{
    // Por ahora, solo una función placeholder
    // Aquí irá la inicialización de GDT, IDT, etc.
}
""")

    create_file("src/arch/x86_64/memory.c", """/* Inicialización básica de memoria x86_64 */
#include <arch/x86_64/memory.h>

void x86_64_memory_init(void) 
{
    // Por ahora, solo una función placeholder
    // Aquí irá la inicialización de paginación, gestión de memoria, etc.
}
""")

    # Headers en src/arch/x86_64/include/
    create_file("src/arch/x86_64/include/cpu.h", """#ifndef CPU_H
#define CPU_H

void x86_64_cpu_init(void);

#endif
""")

    create_file("src/arch/x86_64/include/memory.h", """#ifndef MEMORY_H
#define MEMORY_H

void x86_64_memory_init(void);

#endif
""")

    # Archivos en src/lib/
    create_file("src/lib/string.c", """/* Funciones básicas de manejo de strings */
#include <lib/string.h>

size_t strlen(const char* str) 
{
    size_t len = 0;
    while (str[len] != '\\0') {
        len++;
    }
    return len;
}

void* memset(void* ptr, int value, size_t num) 
{
    unsigned char* p = (unsigned char*)ptr;
    for (size_t i = 0; i < num; i++) {
        p[i] = (unsigned char)value;
    }
    return ptr;
}

void* memcpy(void* dest, const void* src, size_t num) 
{
    unsigned char* d = (unsigned char*)dest;
    const unsigned char* s = (const unsigned char*)src;
    for (size_t i = 0; i < num; i++) {
        d[i] = s[i];
    }
    return dest;
}
""")

    create_file("src/lib/string.h", """#ifndef STRING_H
#define STRING_H

#include <stddef.h>

size_t strlen(const char* str);
void* memset(void* ptr, int value, size_t num);
void* memcpy(void* dest, const void* src, size_t num);

#endif
""")

    # Scripts
    create_file("scripts/build.sh", """#!/bin/bash

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
ld -n -T src/boot/linker.ld -o ${BUILD_DIR}/${KERNEL_NAME}.elf \\
    ${BUILD_DIR}/multiboot2.o \\
    ${BUILD_DIR}/boot.o \\
    ${BUILD_DIR}/main.o \\
    ${BUILD_DIR}/printk.o \\
    ${BUILD_DIR}/panic.o \\
    ${BUILD_DIR}/cpu.o \\
    ${BUILD_DIR}/memory.o \\
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
""")

    create_file("scripts/run_qemu.sh", """#!/bin/bash

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
""")

    # Makefile
    create_file("Makefile", """# Makefile para el Proyecto Prometeo

.PHONY: all clean run

all:
\t@./scripts/build.sh

clean:
\t@rm -rf build/

run: all
\t@./scripts/run_qemu.sh

debug: all
\t@echo "Ejecutando en modo debug..."
\t@qemu-system-x86_64 -cdrom build/prometeo.iso -m 512M -serial stdio -s -S

help:
\t@echo "Targets disponibles:"
\t@echo "  all    - Compilar el kernel (por defecto)"
\t@echo "  clean  - Limpiar archivos de build"
\t@echo "  run    - Compilar y ejecutar en QEMU"
\t@echo "  debug  - Compilar y ejecutar en modo debug (GDB)"
""")

    # .gitignore
    create_file(".gitignore", """# Build artifacts
/build/
*.iso
*.elf
*.o

# Editor files
*.swp
*~
.vscode/
.idea/

# OS generated files
.DS_Store
Thumbs.db
""")

    # Hacer ejecutables los scripts
    make_executable("scripts/build.sh")
    make_executable("scripts/run_qemu.sh")

    print("\\n🎉 ¡Estructura del Proyecto Prometeo creada exitosamente!")
    print("\\n📝 Próximos pasos:")
    print("1. Instalar dependencias: nasm, gcc, ld, grub, qemu")
    print("2. Ejecutar: make all")
    print("3. Ejecutar: make run")
    print("\\n🔥 ¡El código del kernel está listo para construir!")

if __name__ == "__main__":
    main()
