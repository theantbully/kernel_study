#!/bin/sh
LINUX_RELEASE=focal

# should start kernel with full rootfs!
sudo ssh -i ./${LINUX_RELEASE}.id_rsa -p 10021 -o "StrictHostKeyChecking no" root@localhost


