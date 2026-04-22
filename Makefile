# Proyecto Prometeo - Makefile para kernel 32-bit
CC := gcc
ASM := nasm
LD := ld

CFLAGS := -ffreestanding -nostdlib -nostdinc -fno-builtin -fno-stack-protector -m32 -I./src/include
ASMFLAGS := -f elf32
LDFLAGS := -T linker.ld -melf_i386 -nostdlib

OBJS := obj/boot/multiboot2.o \
        obj/boot/boot.o \
        obj/kernel/main.o \
        obj/kernel/printk.o \
        obj/kernel/panic.o \
        obj/arch/x86_64/cpu.o \
        obj/arch/x86_64/memory.o \
        obj/lib/string.o

all: bin/prometeo-kernel

bin/prometeo-kernel: $(OBJS)
	@mkdir -p bin
	@echo "  🔗 Enlazando el kernel..."
	@$(LD) $(LDFLAGS) -o $@ $^
	@echo "  ✅ Kernel compilado: bin/prometeo-kernel"

obj/%.o: src/%.c
	@mkdir -p $(dir $@)
	@echo "  📄 Compilando $<..."
	@$(CC) $(CFLAGS) -c $< -o $@

obj/%.o: src/%.asm
	@mkdir -p $(dir $@)
	@echo "  📄 Ensamblando $<..."
	@$(ASM) $(ASMFLAGS) -o $@ $<

clean:
	@echo "  🧹 Limpiando..."
	@rm -rf obj bin

run: bin/prometeo-kernel
	@echo "  🚀 Iniciando QEMU..."
	@qemu-system-x86_64 -kernel bin/prometeo-kernel -serial stdio -no-reboot

.PHONY: all clean run
