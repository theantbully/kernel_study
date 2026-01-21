/* linker.ld - 链接脚本 */
ENTRY(_start)

SECTIONS
{
    /* 内核加载到 1MB 地址 */
    . = 0x100000;
    
    .text : {
        *(.multiboot)
        *(.text)
    }
    
    .rodata : {
        *(.rodata)
    }
    
    .data : {
        *(.data)
    }
    
    .bss : {
        *(.bss)
        *(COMMON)
    }
}

