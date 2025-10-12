/**
 * @file printk.c
 * @brief Implementación de funciones de impresión para el kernel
 */

#include "printk.h"

/* Dirección de memoria de video para modo texto VGA */
volatile unsigned short *video_memory = (unsigned short *)0xB8000;
int cursor_pos = 0;

/**
 * @brief Limpia la pantalla
 */
void clear_screen(void) {
    for (int i = 0; i < 80 * 25; i++) {
        video_memory[i] = (0x07 << 8) | ' ';
    }
    cursor_pos = 0;
}

/**
 * @brief Imprime un carácter en la pantalla
 * @param c Carácter a imprimir
 */
void putchar(char c) {
    if (c == '\n') {
        cursor_pos = (cursor_pos + 80) - (cursor_pos % 80);
    } else {
        video_memory[cursor_pos] = (0x07 << 8) | c;
        cursor_pos++;
    }
    
    /* Scroll si llegamos al final de la pantalla */
    if (cursor_pos >= 80 * 25) {
        for (int i = 0; i < 80 * 24; i++) {
            video_memory[i] = video_memory[i + 80];
        }
        for (int i = 80 * 24; i < 80 * 25; i++) {
            video_memory[i] = (0x07 << 8) | ' ';
        }
        cursor_pos = 80 * 24;
    }
}

/**
 * @brief Imprime una cadena de caracteres
 * @param str Cadena a imprimir
 */
void puts(const char *str) {
    while (*str) {
        putchar(*str++);
    }
}

/**
 * @brief Convierte un número a string en base específica
 * @param value Número a convertir
 * @param buffer Buffer donde guardar el string
 * @param base Base numérica (10, 16, etc.)
 * @return Puntero al buffer
 */
char *itoa(int value, char *buffer, int base) {
    char *p = buffer;
    char *p1, *p2;
    int digits = 0;
    
    // Manejar números negativos en base 10
    if (value < 0 && base == 10) {
        *p++ = '-';
        value = -value;
    }
    
    p1 = p;
    
    do {
        int digit = value % base;
        *p++ = (digit < 10) ? '0' + digit : 'A' + digit - 10;
        value /= base;
    } while (value > 0);
    
    *p-- = '\0';
    
    // Invertir el string
    while (p1 < p) {
        char tmp = *p1;
        *p1++ = *p;
        *p-- = tmp;
    }
    
    return buffer;
}

/**
 * @brief Implementación básica de printk
 * @param format Cadena de formato
 * @param ... Argumentos variables
 * @return Número de caracteres impresos
 */
int printk(const char *format, ...) {
    va_list args;
    va_start(args, format);
    
    int chars_printed = 0;
    char buffer[32];
    
    while (*format) {
        if (*format == '%') {
            format++;
            switch (*format) {
                case 's': {
                    char *str = va_arg(args, char*);
                    puts(str);
                    while (*str) {
                        chars_printed++;
                        str++;
                    }
                    break;
                }
                case 'd': {
                    int num = va_arg(args, int);
                    itoa(num, buffer, 10);
                    puts(buffer);
                    char *p = buffer;
                    while (*p) {
                        chars_printed++;
                        p++;
                    }
                    break;
                }
                case 'x': {
                    int num = va_arg(args, int);
                    itoa(num, buffer, 16);
                    puts(buffer);
                    char *p = buffer;
                    while (*p) {
                        chars_printed++;
                        p++;
                    }
                    break;
                }
                case 'c': {
                    char c = (char)va_arg(args, int);
                    putchar(c);
                    chars_printed++;
                    break;
                }
                case '%': {
                    putchar('%');
                    chars_printed++;
                    break;
                }
                default:
                    putchar('%');
                    putchar(*format);
                    chars_printed += 2;
                    break;
            }
        } else {
            putchar(*format);
            chars_printed++;
        }
        format++;
    }
    
    va_end(args);
    return chars_printed;
}
