/**
 * @file printk.h
 * @brief Funciones de impresión para el kernel Prometeo
 * @author Equipo Prometeo
 * @date 2025
 * @license MIT
 */

#ifndef _PRINTK_H
#define _PRINTK_H

/**
 * @brief Imprime un mensaje en la consola del kernel
 * @param str Cadena a imprimir
 */
void printk(const char *str);

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
/**
 * @brief Limpia la pantalla
 */
void clear_screen(void);

#endif /* _PRINTK_H */
