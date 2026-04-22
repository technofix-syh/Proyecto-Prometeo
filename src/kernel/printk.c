#include "printk.h"

/* Memoria de video VGA en modo texto (80x25) */
volatile unsigned short *video_memory = (unsigned short *)0xB8000;
int cursor_pos = 0;

void clear_screen(void) {
    for (int i = 0; i < 80 * 25; i++) {
        video_memory[i] = (0x07 << 8) | ' ';
    }
    cursor_pos = 0;
}

void putchar(char c) {
    if (c == '\n') {
        cursor_pos = (cursor_pos + 80) - (cursor_pos % 80);
    } else {
        video_memory[cursor_pos] = (0x07 << 8) | c;
        cursor_pos++;
    }

    if (cursor_pos >= 80 * 25) {
        for (int i = 0; i < 80 * 24; i++)
            video_memory[i] = video_memory[i + 80];
        for (int i = 80 * 24; i < 80 * 25; i++)
            video_memory[i] = (0x07 << 8) | ' ';
        cursor_pos = 80 * 24;
    }
}

void puts(const char *str) {
    while (*str)
        putchar(*str++);
}

void printk(const char *str) {
    puts(str);
}
