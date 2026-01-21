#!/bin/sh
cat list | cpio -o -H newc > init.cpio
