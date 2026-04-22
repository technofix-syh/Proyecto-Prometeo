#ifndef _PRINTK_H
#define _PRINTK_H

/* Funciones básicas de impresión en el kernel */
void printk(const char *str);
void putchar(char c);
void puts(const char *str);
void clear_screen(void);

#endif
