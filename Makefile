# Makefile para el Proyecto Prometeo

.PHONY: all clean run deps

all:
	@./scripts/build.sh

clean:
	@echo "🧹 Limpiando archivos de build..."
	@rm -rf build/

run: all
	@./scripts/run_qemu.sh

debug: all
	@echo "🐛 Ejecutando en modo debug..."
	@qemu-system-x86_64 -cdrom build/prometeo.iso -m 512M -serial stdio -s -S

deps:
	@echo "📦 Instalando dependencias..."
	@sudo apt update
	@sudo apt install -y nasm grub2-common grub-pc-bin qemu-system-x86

help:
	@echo "Targets disponibles:"
	@echo "  all    - Compilar el kernel (por defecto)"
	@echo "  clean  - Limpiar archivos de build"
	@echo "  run    - Compilar y ejecutar en QEMU"
	@echo "  debug  - Compilar y ejecutar en modo debug (GDB)"
	@echo "  deps   - Instalar dependencias del sistema"
