################################################################################
#
# toolchain-external-p64h
#
################################################################################

HOST_RISCV_LLVM_PATH := $(BR2_TOOLCHAIN_EXTERNAL_P64H_HOST_RISCV_LLVM_PATH)
NATIVE_RISCV_LLVM_PATH := $(BR2_TOOLCHAIN_EXTERNAL_P64H_NATIVE_RISCV_LLVM_PATH)

ifeq ($(BR2_TOOLCHAIN_EXTERNAL_P64H_LIBS_LLVM_DEVEL),y)
ifeq ($(call qstrip,$(NATIVE_RISCV_LLVM_PATH)),)
$(error NATIVE_RISCV_LLVM_PATH must be set to a valid path in order to build llvm-devel)
endif
ifeq ($(call qstrip,$(HOST_RISCV_LLVM_PATH)),)
$(error HOST_RISCV_LLVM_PATH must be set to a valid path in order to build llvm-devel)
endif
endif

ifeq ($(BR2_TOOLCHAIN_EXTERNAL_P64H_LIBS_STD_DEVEL_LIBS),y)
ifeq ($(call qstrip,$(HOST_RISCV_LLVM_PATH)),)
$(error HOST_RISCV_LLVM_PATH must be set to a valid path in order to build std-devel-libs)
endif
endif

define BR2_TOOLCHAIN_EXTERNAL_P64H_INSTALL_EXTRA_LIBS
	cp -a $(RISCV_PATH)/sysroot/lib/*.so* $(TARGET_DIR)/lib/
endef

define BR2_TOOLCHAIN_EXTERNAL_P64H_INSTALL_LLVM_DEVEL
	cp -a  $(NATIVE_RISCV_LLVM_PATH)/* $(STAGING_DIR)/usr/
	cp     $(HOST_RISCV_LLVM_PATH)/bin/riscv64-unknown-linux-gnu-llvm-config $(STAGING_DIR)/usr/bin/
	ln -fs ../usr/bin/riscv64-unknown-linux-gnu-llvm-config $(STAGING_DIR)/bin/riscv64-unknown-linux-gnu-llvm-config
endef

define BR2_TOOLCHAIN_EXTERNAL_P64H_INSTALL_STD_DEVEL_LIBS
	cp -a  $(HOST_RISCV_LLVM_PATH)/lib/gcc $(STAGING_DIR)/usr/lib
	cp -a  $(HOST_RISCV_LLVM_PATH)/riscv64-unknown-linux-gnu/include/c++ $(STAGING_DIR)/usr/include/
endef

ifeq ($(BR2_TOOLCHAIN_EXTERNAL_P64H_COPY_TOOLCHAIN_SYSROOT),y)
TOOLCHAIN_EXTERNAL_P64H_POST_INSTALL_TARGET_HOOKS += BR2_TOOLCHAIN_EXTERNAL_P64H_INSTALL_EXTRA_LIBS
endif

ifeq ($(BR2_TOOLCHAIN_EXTERNAL_P64H_LIBS_LLVM_DEVEL),y)
TOOLCHAIN_EXTERNAL_P64H_POST_INSTALL_STAGING_HOOKS += BR2_TOOLCHAIN_EXTERNAL_P64H_INSTALL_LLVM_DEVEL
endif

ifeq ($(BR2_TOOLCHAIN_EXTERNAL_P64H_LIBS_STD_DEVEL_LIBS),y)
TOOLCHAIN_EXTERNAL_P64H_POST_INSTALL_STAGING_HOOKS += BR2_TOOLCHAIN_EXTERNAL_P64H_INSTALL_STD_DEVEL_LIBS
endif

$(eval $(toolchain-external-package))
