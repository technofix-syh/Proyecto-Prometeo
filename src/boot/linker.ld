/* Script del linker para el kernel */
ENTRY(_start)

SECTIONS
{
    . = 1M;

    .boot :
    {
        /* Asegurar que el header multiboot esté al inicio */
        *(.multiboot_header)
    }

    .text :
    {
        *(.text)
    }

    .data :
    {
        *(.data)
    }

    .bss :
    {
        *(.bss)
    }
}
