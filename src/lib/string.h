#ifndef _LIB_STRING_H
#define _LIB_STRING_H

typedef unsigned int size_t;

void *memset(void *dest, int val, size_t n);
void *memcpy(void *dest, const void *src, size_t n);
size_t strlen(const char *s);

#endif
