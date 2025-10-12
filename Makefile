# 🔥 Makefile del Proyecto Prometeo - Rutas Corregidas 🔥
# Configuración del compilador y banderas
CC := gcc
ASM := nasm
CFLAGS := -ffreestanding -nostdlib -nostdinc -fno-builtin -fno-stack-protector -m32 -I./src/include -I./src/lib
ASMFLAGS := -f elf32
LDFLAGS := -T linker.ld -melf_i386

# 📁 Archivos objeto a generar (RUTAS CORREGIDAS SEGÚN TU ESTRUCTURA)
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
	@ld $(LDFLAGS) -o $@ $^

# 🛠️ Compilar archivos C
obj/%.o: src/%.c
	@mkdir -p $(dir $@)
	@echo "  📄 Compilando $<..."
	@$(CC) $(CFLAGS) -c $< -o $@

# ⚙️ Ensamblar archivos ASM
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
	@qemu-system-x86_64 -kernel bin/prometeo-kernel -serial stdio -no-reboot

.PHONY: all clean run
