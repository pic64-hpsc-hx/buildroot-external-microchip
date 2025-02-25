################################################################################
#
# toolchain-external-p64h
#
################################################################################
CROSS_LLVM_PATH:=$(BR2_TOOLCHAIN_EXTERNAL_PATH)

ifeq ($(BR2_TOOLCHAIN_EXTERNAL_P64H_LIBS_LLVM_DEVEL),y)
ifeq ($(call qstrip,$(RISCV_LLVM_PATH)),)
$(error RISCV_LLVM_PATH must be set to a valid path in order to build llvm-devel)
endif
ifeq ($(call qstrip,$(CROSS_LLVM_PATH)),)
$(error CROSS_LLVM_PATH must be set to a valid path in order to build llvm-devel)
endif
endif

ifeq ($(BR2_TOOLCHAIN_EXTERNAL_P64H_LIBS_STD_DEVEL_LIBS),y)
ifeq ($(call qstrip,$(CROSS_LLVM_PATH)),)
$(error CROSS_LLVM_PATH must be set to a valid path in order to build std-devel-libs)
endif
endif

define BR2_TOOLCHAIN_EXTERNAL_P64H_INSTALL_EXTRA_LIBS
	$(BR2_EXTERNAL_MCHP_PATH)/board/microchip/p64h/common-scripts/copy_toolchain_sysroot.sh
endef

define BR2_TOOLCHAIN_EXTERNAL_P64H_INSTALL_LLVM_DEVEL
	cp -a  $(RISCV_LLVM_PATH)/* $(STAGING_DIR)/usr/
	cp     $(CROSS_LLVM_PATH)/bin/riscv64-unknown-linux-gnu-llvm-config $(STAGING_DIR)/usr/bin/
	ln -fs ../usr/bin/riscv64-unknown-linux-gnu-llvm-config $(STAGING_DIR)/bin/riscv64-unknown-linux-gnu-llvm-config
endef

define BR2_TOOLCHAIN_EXTERNAL_P64H_INSTALL_STD_DEVEL_LIBS
	cp -a  $(CROSS_LLVM_PATH)/lib/gcc $(STAGING_DIR)/usr/lib
	cp -a  $(CROSS_LLVM_PATH)/riscv64-unknown-linux-gnu/include/c++ $(STAGING_DIR)/usr/include/
endef

TOOLCHAIN_EXTERNAL_P64H_POST_INSTALL_STAGING_HOOKS += BR2_TOOLCHAIN_EXTERNAL_P64H_INSTALL_EXTRA_LIBS

ifeq ($(BR2_TOOLCHAIN_EXTERNAL_P64H_LIBS_LLVM_DEVEL),y)
TOOLCHAIN_EXTERNAL_P64H_POST_INSTALL_STAGING_HOOKS += BR2_TOOLCHAIN_EXTERNAL_P64H_INSTALL_LLVM_DEVEL
endif

ifeq ($(BR2_TOOLCHAIN_EXTERNAL_P64H_LIBS_STD_DEVEL_LIBS),y)
TOOLCHAIN_EXTERNAL_P64H_POST_INSTALL_STAGING_HOOKS += BR2_TOOLCHAIN_EXTERNAL_P64H_INSTALL_STD_DEVEL_LIBS
endif

$(eval $(toolchain-external-package))