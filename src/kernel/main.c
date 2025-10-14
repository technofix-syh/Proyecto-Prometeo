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
    
    // Mostrar mensajes simples sin formato
    printk(">>> [PROMETEO] Kernel booteado exitosamente! <<<\n");
    printk(">>> Version: 0.1.0 <<<\n"); 
    printk(">>> Modo: 32-bit Protected Mode <<<\n");
    printk(">>> Proyecto Prometeo - Unificando ecosistemas <<<\n\n");
    printk("*** EL FUEGO DE PROMETEO SE HA ENCENDIDO! ***\n");
    printk("*** Boot exitoso - Meta-kernel activo ***\n");
    
    // Loop infinito
    while (1) {
        // El kernel está ejecutándose exitosamente
    }
}
