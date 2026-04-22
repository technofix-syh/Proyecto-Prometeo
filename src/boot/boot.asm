bits 32
section .text
global start
extern kernel_main          ; <-- Declarar que kernel_main está en otro archivo

start:
    ; Configurar segmentos
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    ; Stack pointer
    mov esp, 0x90000
    mov ebp, esp

    ; Limpiar pantalla (escribe espacios)
    mov edi, 0xB8000
    mov ecx, 80*25
    mov ax, 0x0720
.clear:
    mov [edi], ax
    add edi, 2
    loop .clear

    ; Mostrar mensaje de bootloader
    mov esi, boot_msg
    mov edi, 0xB8000
    mov ah, 0x0F
.print:
    lodsb
    test al, al
    jz .call_kernel
    mov [edi], ax
    add edi, 2
    jmp .print

.call_kernel:
    call kernel_main        ; Ahora sí, la función existe

    ; En caso de retorno, detener
    cli
.halt:
    hlt
    jmp .halt

boot_msg:
    db '>>> [PROMETEO] Bootloader activo, llamando al kernel...', 0

; Header Multiboot2 (debe estar en los primeros 8KB)
section .multiboot
align 8
multiboot_header:
    dd 0xE85250D6
    dd 0
    dd multiboot_header_end - multiboot_header
    dd 0x100000000 - (0xE85250D6 + 0 + (multiboot_header_end - multiboot_header))
    dw 0
    dw 0
    dd 8
multiboot_header_end:
