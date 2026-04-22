bits 32
section .text
global start

start:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    mov esp, 0x90000
    mov ebp, esp

    ; Limpiar pantalla
    mov edi, 0xB8000
    mov ecx, 80*25
    mov ax, 0x0720
.clear:
    mov [edi], ax
    add edi, 2
    loop .clear

    ; Mostrar mensaje
    mov esi, boot_msg
    mov edi, 0xB8000
    mov ah, 0x0F
.print:
    lodsb
    test al, al
    jz .halt
    mov [edi], ax
    add edi, 2
    jmp .print

.halt:
    call kernel_main
    cli
.hlt_loop:
    hlt
    jmp .hlt_loop

boot_msg:
    db '>>> [PROMETEO] Bootloader activo, llamando al kernel...', 0

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
