#!/bin/sh
# build kernel
# download kernel src & uncompress into kernel.
cd kernel 
make clean mrproper distclean   # 执行清理
make defconfig
make kvm_guest.config
make -j4 
echo "=============== make kernel finished ================="

