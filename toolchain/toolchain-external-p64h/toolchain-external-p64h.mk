################################################################################
#
# toolchain-external-p64h
#
################################################################################

TOOLCHAIN_EXTERNAL_LIBS += libarcher.so* libBrokenLocale.so* libc++abi.so* libc_malloc_debug.so* libc++.so* libiomp5.so* libitm.so*\
 libmemusage.so* libnss_compat.so* libnss_db.so* libnss_hesiod.so* libompd.so* libpcprofile.so* libthread_db.so*

define BR2_TOOLCHAIN_EXTERNAL_P64H_INSTALL_LLVM_DEVEL
	cp -a  $(RISCV_LLVM_PATH)/* $(STAGING_DIR)/usr/
	cp     $(CROSS_LLVM_PATH)/bin/riscv64-unknown-linux-gnu-llvm-config $(STAGING_DIR)/usr/bin/
	ln -fs ../usr/bin/riscv64-unknown-linux-gnu-llvm-config $(STAGING_DIR)/bin/riscv64-unknown-linux-gnu-llvm-config
endef

define BR2_TOOLCHAIN_EXTERNAL_P64H_INSTALL_STD_DEVEL_LIBS
	cp -a  $(CROSS_LLVM_PATH)/lib/gcc $(STAGING_DIR)/usr/lib
	cp -a  $(CROSS_LLVM_PATH)/riscv64-unknown-linux-gnu/include/c++ $(STAGING_DIR)/usr/include/
endef

ifeq ($(BR2_PACKAGE_P64H_LIBS_LLVM_DEVEL),y)
TOOLCHAIN_EXTERNAL_P64H_POST_INSTALL_STAGING_HOOKS += BR2_TOOLCHAIN_EXTERNAL_P64H_INSTALL_LLVM_DEVEL
endif

ifeq ($(BR2_PACKAGE_P64H_LIBS_STD_DEVEL_LIBS),y)
TOOLCHAIN_EXTERNAL_P64H_POST_INSTALL_STAGING_HOOKS += BR2_TOOLCHAIN_EXTERNAL_P64H_INSTALL_STD_DEVEL_LIBS
endif

$(eval $(toolchain-external-package))