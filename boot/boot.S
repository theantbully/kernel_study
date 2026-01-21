# boot.S - 最简单的 x86_64 内核启动代码 (彩色显示)
.code32

# Multiboot 1 头 (QEMU兼容)
.set ALIGN,    1<<0             # 定义对齐位
.set MEMINFO,  1<<1             # 定义内存信息位
.set FLAGS,    ALIGN | MEMINFO  # 启用对齐+内存信息
.set MAGIC,    0x1BADB002       # Multiboot 魔数
.set CHECKSUM, -(MAGIC + FLAGS) # 校验和

.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

# 栈空间
.section .bss
.align 16
stack_bottom:
    .skip 16384  # 16KB 栈空间
stack_top:

# 内核入口点
.section .text
.globl _start

# 32位模式入口(实模式??)
_start:
    # 设置栈指针
    mov $stack_top, %esp

    # 清除方向标志
    cld

    # 初始化段寄存器
    mov $0x10, %eax
    mov %eax, %ds
    mov %eax, %es
    mov %eax, %fs
    mov %eax, %gs
    mov %eax, %ss

    # 调用C函数
    call kmain

    # 停机循环
.hang:
    cli
    hlt
    jmp .hang

