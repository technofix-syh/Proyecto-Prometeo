#include "lib/string.h"

void *memset(void *dest, int val, size_t n) {
    unsigned char *p = dest;
    while (n--) *p++ = (unsigned char)val;
    return dest;
}

void *memcpy(void *dest, const void *src, size_t n) {
    unsigned char *d = dest;
    const unsigned char *s = src;
    while (n--) *d++ = *s++;
    return dest;
}

size_t strlen(const char *s) {
    size_t len = 0;
    while (*s++) len++;
    return len;
}
