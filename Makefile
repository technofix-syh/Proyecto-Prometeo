# 🔥 Makefile del Proyecto Prometeo - Configuración 32-bit Corregida 🔥

# Configuración del compilador y banderas
CC := gcc
ASM := nasm
LD := ld

# Banderas específicas para arquitectura 32-bit
CFLAGS := -ffreestanding -nostdlib -nostdinc -fno-builtin -fno-stack-protector -m32 -I./src/include -I./src/lib
ASMFLAGS := -f elf32
LDFLAGS := -T linker.ld -melf_i386 -nostdlib

# 📁 Archivos objeto a generar
OBJS := obj/boot/multiboot2.o \
        obj/boot/boot.o \
        obj/kernel/main.o \
        obj/kernel/printk.o \
        obj/kernel/panic.o \
        obj/arch/x86_64/cpu.o \
        obj/arch/x86_64/memory.o \
        obj/lib/string.o

# 🎯 Objetivo principal
all: bin/prometeo-kernel

# 🔨 Enlazar el kernel
bin/prometeo-kernel: $(OBJS)
	@mkdir -p bin
	@echo "  🔗 Enlazando el kernel..."
	@$(LD) $(LDFLAGS) -o $@ $^
	@echo "  ✅ Kernel compilado: bin/prometeo-kernel"

# 🛠️ Compilar archivos C
obj/%.o: src/%.c
	@mkdir -p $(dir $@)
	@echo "  📄 Compilando $<..."
	@$(CC) $(CFLAGS) -c $< -o $@

# ⚙️ Ensamblar archivos ASM (CORREGIDO para 32-bit)
obj/%.o: src/%.asm
	@mkdir -p $(dir $@)
	@echo "  📄 Ensamblando $<..."
	@$(ASM) $(ASMFLAGS) -o $@ $<

# 🧹 Limpiar archivos de compilación
clean:
	@echo "  🧹 Limpiando..."
	@rm -rf obj bin

# 🚀 Ejecutar en QEMU
run: bin/prometeo-kernel
	@echo "  🚀 Iniciando QEMU..."
	@qemu-system-x86_64 -kernel bin/prometeo-kernel -serial stdio -no-reboot -d cpu_reset

# 🔍 Debug con QEMU y GDB
debug: bin/prometeo-kernel
	@echo "  🐛 Iniciando QEMU en modo debug..."
	@qemu-system-x86_64 -kernel bin/prometeo-kernel -serial stdio -no-reboot -s -S &

.PHONY: all clean run debug
