# Makefile - 编译内核启动代码 (修复VGA显示)
CC=gcc
AS=as
LD=ld
CFLAGS=-m32 -ffreestanding -fno-stack-protector -fno-pic -nostdlib -nostartfiles
LDFLAGS=-T linker.ld -m elf_i386

# 目标文件
TARGET_ELF=kernel.elf
TARGET_BIN=kernel.bin
ASM_SRC=boot.S
C_SRC=kernel.c
OBJ_FILES=boot.o kernel.o

# 默认目标
all: $(TARGET_BIN)

# 生成二进制文件
$(TARGET_BIN): $(TARGET_ELF)
	objcopy -O binary $(TARGET_ELF) $(TARGET_BIN)

# 链接目标文件生成ELF内核镜像
$(TARGET_ELF): $(OBJ_FILES)
	$(LD) $(LDFLAGS) -o $(TARGET_ELF) $(OBJ_FILES)

# 编译汇编源文件
boot.o: boot.S
	$(AS) --32 -o $@ $<

# 编译C源文件
kernel.o: kernel.c
	$(CC) $(CFLAGS) -c -o $@ $<

# 清理中间文件
clean:
	rm -f *.o $(TARGET_ELF) $(TARGET_BIN)

# 运行 QEMU 测试 (使用ELF文件)
run: $(TARGET_ELF)
	qemu-system-x86_64 -kernel $(TARGET_ELF) -vga std -serial stdio

# 运行 QEMU 测试 (使用二进制文件)
run-bin: $(TARGET_BIN)
	qemu-system-x86_64 -fda $(TARGET_BIN) -vga std -serial stdio

# 安装依赖命令
install-deps:
	sudo apt update
	sudo apt install build-essential nasm qemu-system-x86 gcc-multilib binutils

.PHONY: all clean run run-bin install-deps

