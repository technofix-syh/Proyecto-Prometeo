/* Punto de entrada principal del kernel */
#include <kernel/printk.h>
#include <arch/x86_64/cpu.h>
#include <arch/x86_64/memory.h>

void kernel_main(void) 
{
    // Inicializar sistema de logging
    printk_init();
    
    printk("=== Proyecto Prometeo ===\n");
    printk("Kernel booteado exitosamente!\n");
    printk("Inicializando sistema...\n");
    
    // Inicializar arquitectura x86_64
    x86_64_cpu_init();
    x86_64_memory_init();
    
    printk("Sistema inicializado. Entrando en loop principal...\n");
    
    // Loop principal del kernel
    while (1) {
        asm volatile ("hlt");
    }
}
