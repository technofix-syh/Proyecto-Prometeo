/**
 * @file string.h
 * @brief Funciones básicas para manipulación de cadenas (strings)
 * @author Equipo Prometeo
 * @date 2025
 * @license MIT
 */

#ifndef _STRING_H
#define _STRING_H

#include <stddef.h>
#include <stdint.h>

/**
 * @brief Copia un bloque de memoria de una ubicación a otra
 * @param dest Puntero al destino de la copia
 * @param src Puntero a la fuente de datos
 * @param n Número de bytes a copiar
 * @return Puntero al destino
 */
void *memcpy(void *dest, const void *src, size_t n);

/**
 * @brief Establece un bloque de memoria con un valor específico
 * @param dest Puntero al bloque de memoria a establecer
 * @param val Valor a establecer (convertido a unsigned char)
 * @param n Número de bytes a establecer
 * @return Puntero al bloque de memoria
 */
void *memset(void *dest, int val, size_t n);

/**
 * @brief Mueve un bloque de memoria entre dos ubicaciones (puede solaparse)
 * @param dest Puntero al destino
 * @param src Puntero a la fuente
 * @param n Número de bytes a mover
 * @return Puntero al destino
 */
void *memmove(void *dest, const void *src, size_t n);

/**
 * @brief Compara dos bloques de memoria
 * @param s1 Puntero al primer bloque
 * @param s2 Puntero al segundo bloque
 * @param n Número de bytes a comparar
 * @return Entero menor, igual o mayor que cero según si s1 es menor, igual o mayor que s2
 */
int memcmp(const void *s1, const void *s2, size_t n);

/**
 * @brief Calcula la longitud de una cadena de caracteres
 * @param str Cadena de caracteres terminada en null
 * @return Longitud de la cadena
 */
size_t strlen(const char *str);

/**
 * @brief Copia una cadena de caracteres a otra ubicación
 * @param dest Destino de la copia
 * @param src Fuente a copiar
 * @return Puntero al destino
 */
char *strcpy(char *dest, const char *src);

/**
 * @brief Compara lexicográficamente dos cadenas de caracteres
 * @param s1 Primera cadena
 * @param s2 Segunda cadena
 * @return Entero menor, igual o mayor que cero según si s1 es menor, igual o mayor que s2
 */
int strcmp(const char *s1, const char *s2);

#endif /* _STRING_H */
