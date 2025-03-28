################################################################################
#
# p64h-openblas: OpenBLAS Library for PIC64-HPSC-HX SoC.
#
################################################################################

P64H_OPENBLAS_VERSION = v0.3.28
P64H_OPENBLAS_SITE = https://github.com/OpenMathLib/OpenBLAS.git
P64H_OPENBLAS_SITE_METHOD = git
P64H_OPENBLAS_LICENSE = MIT
P64H_OPENBLAS_LICENSE_FILES = LICENSE

export OPENBLAS_BUILD_DIR=$(BUILD_DIR)/p64h-openblas-$(P64H_OPENBLAS_VERSION)/install

define P64H_OPENBLAS_BUILD_CMDS
	export PATH=$(PATH):$(BR2_TOOLCHAIN_EXTERNAL_PATH)/bin && \
	make -C $(@D) HOSTCC=gcc TARGET=x280 CC=riscv64-unknown-linux-gnu-clang FC=riscv64-unknown-linux-gnu-gfortran NUM_THREADS=10 CROSS_COMPILE=$(BR2_TOOLCHAIN_EXTERNAL_PATH)/bin/riscv64-unknown-linux-gnu-
	make -C $(@D) HOSTCC=gcc TARGET=x280 CC=riscv64-unknown-linux-gnu-clang FC=riscv64-unknown-linux-gnu-gfortran NUM_THREADS=10 PREFIX=install install CROSS_COMPILE=$(BR2_TOOLCHAIN_EXTERNAL_PATH)/bin/riscv64-unknown-linux-gnu-
endef

define P64H_OPENBLAS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/install/lib/libopenblas_x280p-r0.3.28.so $(TARGET_DIR)/usr/lib/libopenblas_x280p-r0.3.28.so;
	ln -fs libopenblas_x280p-r0.3.28.so $(TARGET_DIR)/usr/lib/libopenblas.so.0;
endef

ifeq ($(P64H_DEBPKG_BUILD),1)
$(eval P64H_OPENBLAS_POST_INSTALL_TARGET_HOOKS += P64H_DEBIAN_PACKAGE_BUILD_OPENBLAS);
P64H_OPENBLAS_DEPENDENCIES = p64h
endif

$(eval $(generic-package))