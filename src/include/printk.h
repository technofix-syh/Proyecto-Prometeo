/**
 * @file printk.h
 * @brief Funciones de impresión para el kernel Prometeo
 * @author Equipo Prometeo
 * @date 2025
 * @license MIT
 */

#ifndef _PRINTK_H
#define _PRINTK_H

#include <stdarg.h>

/**
 * @brief Imprime un mensaje formateado en la consola del kernel
 * @param format Cadena de formato (similar a printf)
 * @param ... Argumentos variables
 * @return Número de caracteres impresos
 */
int printk(const char *format, ...);

/**
 * @brief Imprime un mensaje de emergencia (nivel más alto)
 * @param format Cadena de formato
 * @param ... Argumentos variables
 * @return Número de caracteres impresos
 */
int printk_emerg(const char *format, ...);

/**
 * @brief Imprime un mensaje de alerta
 * @param format Cadena de formato
 * @param ... Argumentos variables
 * @return Número de caracteres impresos
 */
int printk_alert(const char *format, ...);

/**
 * @brief Imprime un mensaje crítico
 * @param format Cadena de formato
 * @param ... Argumentos variables
 * @return Número de caracteres impresos
 */
int printk_crit(const char *format, ...);

/**
 * @brief Imprime un mensaje de error
 * @param format Cadena de formato
 * @param ... Argumentos variables
 * @return Número de caracteres impresos
 */
int printk_err(const char *format, ...);

/**
 * @brief Imprime un mensaje de advertencia
 * @param format Cadena de formato
 * @param ... Argumentos variables
 * @return Número de caracteres impresos
 */
int printk_warning(const char *format, ...);

/**
 * @brief Imprime un mensaje informativo
 * @param format Cadena de formato
 * @param ... Argumentos variables
 * @return Número de caracteres impresos
 */
int printk_info(const char *format, ...);

/**
 * @brief Imprime un mensaje de depuración
 * @param format Cadena de formato
 * @param ... Argumentos variables
 * @return Número de caracteres impresos
 */
int printk_debug(const char *format, ...);

/* Macros para facilitar el uso */
#define pr_emerg(fmt, ...)   printk_emerg(fmt, ##__VA_ARGS__)
#define pr_alert(fmt, ...)   printk_alert(fmt, ##__VA_ARGS__)
#define pr_crit(fmt, ...)    printk_crit(fmt, ##__VA_ARGS__)
#define pr_err(fmt, ...)     printk_err(fmt, ##__VA_ARGS__)
#define pr_warning(fmt, ...) printk_warning(fmt, ##__VA_ARGS__)
#define pr_warn(fmt, ...)    printk_warning(fmt, ##__VA_ARGS__)
#define pr_info(fmt, ...)    printk_info(fmt, ##__VA_ARGS__)
#define pr_debug(fmt, ...)   printk_debug(fmt, ##__VA_ARGS__)

#endif /* _PRINTK_H */
