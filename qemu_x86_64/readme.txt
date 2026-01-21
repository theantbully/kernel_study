follow shell scrtips by [Idx].shell

# How to debug kernel ?
# 0) Enable kernel gdb debug scripts option & build kernel.
# 1) follow 2_qemu_kdgb.sh to run kernel bzImage.
# 2) add "add-auto-load-safe-path ~/qemu/kernel_study/kernel/scripts/gdb" into ~/.gdbinit
# 3) gdb kernel/vmlinux
# (gdb) target remote :1234  # connect kernel with default port 1234
