# Configuración del compilador y ensamblador
CC := gcc
ASM := nasm

# Banderas de compilación
CFLAGS := -ffreestanding -nostdlib -nostdinc -fno-builtin -fno-stack-protector -m32 -I./src/include -I./src/lib
ASMFLAGS := -f elf32
LDFLAGS := -T linker.ld -melf_i386

# Lista de archivos objeto
OBJS := obj/kernel/multiboot2.o \
        obj/kernel/boot.o \
        obj/kernel/main.o \
        obj/kernel/printk.o \
        obj/kernel/panic.o \
        obj/kernel/cpu/cpu.o \
        obj/kernel/memory/memory.o \
        obj/lib/string.o

# Target principal
all: bin/prometeo-kernel

bin/prometeo-kernel: $(OBJS)
	@mkdir -p bin
	@ld $(LDFLAGS) -o $@ $^

# 🔥 REGLA CRÍTICA: Cómo construir objetos desde ASM
obj/%.o: src/%.asm
	@mkdir -p $(dir $@)
	@echo "  📄 Ensamblando $<..."
	@$(ASM) $(ASMFLAGS) -o $@ $<

# Regla para archivos C
obj/%.o: src/%.c
	@mkdir -p $(dir $@)
	@echo "  📄 Compilando $<..."
	@$(CC) $(CFLAGS) -c $< -o $@

clean:
	@echo "  🧹 Limpiando..."
	@rm -rf obj bin

run: bin/prometeo-kernel
	@echo "  🚀 Iniciando QEMU..."
	@qemu-system-x86_64 -kernel bin/prometeo-kernel -serial stdio -no-reboot

.PHONY: all clean run
