#!/bin/sh

# copy toolchain sysroot to target directory
cp -a ${RISCV_PATH}/sysroot/lib/* ${TARGET_DIR}/lib/
