#!/bin/sh
# download bash-5.2-rc2.tar.gz & uncompress into bash5.
cd bash5/
./configure --enable-static-link --prefix=/home/lj/qemu/kernel_study/app/bash_install
make -j4
make install
cd -
cp bash_install/bin/bash .

# rename bash binary to init!
mv bash init


