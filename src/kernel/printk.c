/* Sistema de logging básico para el kernel */
#include <printk.h>

// Driver básico de video (modo texto VGA)
static volatile char* video_memory = (volatile char*)0xb8000;
static int cursor_pos = 0;

void printk_init(void) 
{
    // Limpiar pantalla
    for (int i = 0; i < 80 * 25 * 2; i += 2) {
        video_memory[i] = ' ';
        video_memory[i + 1] = 0x07;  // Gris claro sobre negro
    }
    cursor_pos = 0;
}

void printk(const char* str) 
{
    while (*str) {
        if (*str == '\n') {
            // Nueva línea: mover al inicio de la siguiente línea
            cursor_pos = ((cursor_pos / 160) + 1) * 160;
        } else {
            video_memory[cursor_pos] = *str;
            video_memory[cursor_pos + 1] = 0x07;
            cursor_pos += 2;
        }
        str++;
        
        // Scroll si llegamos al final de la pantalla
        if (cursor_pos >= 80 * 25 * 2) {
            // Por ahora, simplemente volvemos al inicio
            cursor_pos = 0;
        }
    }
}
