#include "printk.h"

void kernel_main(void) {
    clear_screen();

    printk(">>> [PROMETEO] Kernel booteado exitosamente! <<<\n");
    printk(">>> Version: 0.1.0 <<<\n");
    printk(">>> Modo: 32-bit Protected Mode <<<\n");
    printk(">>> Proyecto Prometeo - Unificando ecosistemas <<<\n\n");
    printk("*** EL FUEGO DE PROMETEO SE HA ENCENDIDO! ***\n");
    printk("*** Boot exitoso - Meta-kernel activo ***\n");

    while (1) {
        /* Kernel funcionando */
    }
}
