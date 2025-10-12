/* Manejo de errores críticos del kernel */
#include <printk.h>

void panic(const char* message) 
{
    printk("*** KERNEL PANIC ***\n");
    printk("Error: ");
    printk(message);
    printk("\nSistema detenido.\n");
    
    // Detener el sistema
    while (1) {
        asm volatile ("hlt");
    }
}
