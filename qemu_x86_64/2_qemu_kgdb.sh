#!/bin/sh
# -s表示在端口 1234 开启 GDB 调试服务器；-S表示启动时暂停 CPU 执行
LINUX_RELEASE=focal  # Ubuntu20.04 Release name

# start with full rootfs!
#qemu-system-x86_64 \
#	-m 2G \
#	-smp 2 \
#	-kernel kernel/arch/x86/boot/bzImage \
#	-append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
#	-drive file=./${LINUX_RELEASE}.img,format=raw \
#	-net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
#	-net nic,model=e1000 \
#	 -pidfile vm.pid \
#	-nographic \
#	-s \
#	2>&1 | tee vm.log

# start with simple memory rootfs "init.cpio"
qemu-system-x86_64 \
	-kernel kernel/arch/x86/boot/bzImage \
	-initrd ~/qemu/kernel_study/app/init.cpio \
	-s  # kgdb on port:1234

# How to debug kernel ?
# 1) add "add-auto-load-safe-path ~/qemu/kernel_study/kernel/scripts/gdb" into ~/.gdbinit
# 2) gdb kernel/vmlinux
# (gdb) target remote :1234  # connect kernel

