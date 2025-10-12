/**
 * @file printk.h
 * @brief Funciones de impresión para el kernel Prometeo
 * @author Equipo Prometeo
 * @date 2025
 * @license MIT
 */

#ifndef _PRINTK_H
#define _PRINTK_H

/* Definiciones básicas para reemplazar stdarg.h */
typedef __builtin_va_list va_list;
#define va_start(ap, param) __builtin_va_start(ap, param)
#define va_end(ap) __builtin_va_end(ap)
#define va_arg(ap, type) __builtin_va_arg(ap, type)

/**
 * @brief Imprime un mensaje formateado en la consola del kernel
 * @param format Cadena de formato (similar a printf)
 * @param ... Argumentos variables
 * @return Número de caracteres impresos
 */
int printk(const char *format, ...);

/**
 * @brief Imprime un carácter en la pantalla
 * @param c Carácter a imprimir
 */
void putchar(char c);

/**
 * @brief Imprime una cadena de caracteres
 * @param str Cadena a imprimir
 */
void puts(const char *str);

/**
 * @brief Limpia la pantalla
 */
void clear_screen(void);

#endif /* _PRINTK_H */
