# Makefile para el Proyecto Prometeo

.PHONY: all clean run

all:
	@./scripts/build.sh

clean:
	@rm -rf build/

run: all
	@./scripts/run_qemu.sh

debug: all
	@echo "Ejecutando en modo debug..."
	@qemu-system-x86_64 -cdrom build/prometeo.iso -m 512M -serial stdio -s -S

help:
	@echo "Targets disponibles:"
	@echo "  all    - Compilar el kernel (por defecto)"
	@echo "  clean  - Limpiar archivos de build"
	@echo "  run    - Compilar y ejecutar en QEMU"
	@echo "  debug  - Compilar y ejecutar en modo debug (GDB)"
