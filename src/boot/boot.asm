; ==============================================================================
; Prometeo Bootloader - Modo Protegido 32-bit
; ==============================================================================
bits 32                     ; Especificar modo de 32 bits
section .text
global start                ; Punto de entrada para el linker

; ------------------------------------------------------------------------------
; start - Punto de entrada principal del kernel
; ------------------------------------------------------------------------------
start:
    ; Configurar segmentos de datos
    mov ax, 0x10            ; Selector de segmento de datos en el GDT
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    
    ; Configurar stack pointer
    mov esp, 0x90000        ; Stack en 576KB
    mov ebp, esp
    
    ; Limpiar pantalla (escribir espacios en memoria de video)
    mov edi, 0xB8000        ; Dirección de memoria de video
    mov ecx, 80*25          ; Tamaño de pantalla 80x25
    mov ax, 0x0720          ; Atributo: gris sobre negro, espacio
.clear_screen:
    mov [edi], ax
    add edi, 2
    loop .clear_screen
    
    ; Mostrar mensaje de boot
    mov esi, boot_msg       ; Puntero al mensaje
    mov edi, 0xB8000        ; Posición inicial en pantalla
    mov ah, 0x0F            ; Atributo: blanco sobre negro
.print_msg:
    lodsb                   ; Cargar byte del mensaje
    test al, al             ; ¿Fin del string?
    jz .halt
    mov [edi], ax           ; Escribir carácter y atributo
    add edi, 2
    jmp .print_msg

.halt:
    ; AQUÍ LLAMAREMOS AL KERNEL PRINCIPAL MÁS ADELANTE
    ; call kernel_main
    
    ; Por ahora, halt simple
    cli                     ; Deshabilitar interrupciones
.hlt_loop:
    hlt                     ; Esperar por interrupción
    jmp .hlt_loop

; ------------------------------------------------------------------------------
; Datos del bootloader
; ------------------------------------------------------------------------------
boot_msg:
    db '>>> [PROMETEO] Kernel booteado en modo protegido 32-bit <<<', 0

; ------------------------------------------------------------------------------
; Multiboot2 Header - Debe estar en los primeros 32KB del kernel
; ------------------------------------------------------------------------------
section .multiboot
align 8

; Header de Multiboot2
multiboot_header:
    dd 0xE85250D6          ; Magic number de Multiboot2
    dd 0                   ; Arquitectura 0 (i386)
    dd multiboot_header_end - multiboot_header ; Longitud del header
    
    ; Checksum
    dd 0x100000000 - (0xE85250D6 + 0 + (multiboot_header_end - multiboot_header))
    
    ; Tag de información de framebuffer opcional
    dw 5                   ; Type: framebuffer
    dw 0                   ; Flags: none
    dd 20                  ; Size: 20 bytes
    dd 1024                ; Width
    dd 768                 ; Height
    dd 32                  ; Depth
    
    ; Tag final
    dw 0                   ; Type: end
    dw 0                   ; Flags
    dd 8                   ; Size
multiboot_header_end:
