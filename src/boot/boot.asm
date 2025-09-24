; Punto de entrada del kernel en assembler
section .text
global _start
extern kernel_main

_start:
    ; Establecer stack básico
    mov rsp, stack_top
    
    ; Verificar magic number de Multiboot2
    cmp eax, 0x36d76289
    jne .no_multiboot
    
    ; Llamar al kernel principal en C
    call kernel_main
    
.halt:
    hlt
    jmp .halt

.no_multiboot:
    mov al, '0'
    jmp .error

.error:
    ; Pantalla de error mínima (modo texto)
    mov dword [0xb8000], 0x4f524f45
    mov dword [0xb8004], 0x4f3a4f52
    mov dword [0xb8008], 0x4f204f20
    mov byte  [0xb800a], al
    hlt

section .bss
align 16
stack_bottom:
    resb 16384 ; 16KB stack
stack_top:
