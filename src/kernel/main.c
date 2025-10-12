/**
 * @file main.c
 * @brief Punto de entrada principal del kernel Prometeo
 */

#include "printk.h"

/**
 * @brief Punto de entrada del kernel
 */
void kernel_main(void) {
    // Limpiar pantalla
    clear_screen();
    
    // Mostrar mensaje de boot exitoso
    printk(">>> [PROMETEO] Kernel booteado exitosamente! <<<\n");
    printk(">>> Version: 0.1.0 <<<\n");
    printk(">>> Modo: 32-bit Protected Mode <<<\n");
    printk(">>> Memoria video: 0x%x <<<\n", 0xB8000);
    printk(">>> Proyecto Prometeo - Unificando ecosistemas <<<\n\n");
    
    // Mensaje de celebración
    printk("*** EL FUEGO DE PROMETEO SE HA ENCENDIDO! ***\n");
    printk("*** Boot exitoso - Meta-kernel activo ***\n");
    
    // Loop infinito
    while (1) {
        // El kernel está ejecutándose exitosamente
    }
}
