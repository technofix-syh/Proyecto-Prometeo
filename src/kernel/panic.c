#include "printk.h"

void panic(const char *msg) {
    printk("KERNEL PANIC: ");
    printk(msg);
    printk("\n");
    while (1);
}
