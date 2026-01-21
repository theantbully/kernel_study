#!/bin/bash

# Reference link: https://zhuanlan.zhihu.com/p/993093438

# create rootfs
set -ex

# focal: Ubuntu 20.04 Release name
LINUX_RELEASE=focal

rm -rf ${LINUX_RELEASE}.img
#rm -rf ${LINUX_RELEASE}

#debootstrap --include="openssh-server,vim,net-tools,network-manager,ethtool" \
#	${LINUX_RELEASE} ${LINUX_RELEASE} http://mirrors.cloud.tencent.com/ubuntu/

sed -i '/^root/ { s/:x:/::/ }' ${LINUX_RELEASE}/etc/passwd
echo 'T0:23:respawn:/sbin/getty -L ttyS0 115200 vt100' | tee -a ${LINUX_RELEASE}/etc/inittab
cat >> ${LINUX_RELEASE}/etc/netplan/01-netcfg.yaml<< EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: yes
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]
EOF
echo '/dev/root / ext4 defaults 0 0' | tee -a ${LINUX_RELEASE}/etc/fstab
echo -en "127.0.0.1\tlocalhost\n" | tee ${LINUX_RELEASE}/etc/hosts
echo "nameserver 8.8.8.8" | tee -a ${LINUX_RELEASE}/etc/resolv.conf
ssh-keygen -f ${LINUX_RELEASE}.id_rsa -t rsa -N ''
mkdir -p ${LINUX_RELEASE}/root/.ssh/
cat ${LINUX_RELEASE}.id_rsa.pub | tee ${LINUX_RELEASE}/root/.ssh/authorized_keys


echo "create ${LINUX_RELEASE}.img in /mnt/ ...."
dd if=/dev/zero of=${LINUX_RELEASE}.img bs=1M seek=2047 count=1
mkfs.ext4 -F ${LINUX_RELEASE}.img
mkdir -p /mnt/${LINUX_RELEASE}
mount -o loop ${LINUX_RELEASE}.img /mnt/${LINUX_RELEASE}/
cp -a ${LINUX_RELEASE}/. /mnt/${LINUX_RELEASE}/.
umount /mnt/${LINUX_RELEASE}

echo "all finished !!"
echo "default username: root"
echo "no password needed!"


