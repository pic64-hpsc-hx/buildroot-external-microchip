################################################################################
#
# p64h-libs: Shared Libraries for PIC64-HPSC-HX SoC.
#
################################################################################

CROSS_LLVM_PATH:=$(RISCV_PATH)

P64H_LIBS_SITE = $(P64H_TOPDIR)/install/libs
P64H_LIBS_LICENSE = MIT
P64H_LIBS_LICENSE_FILES = LICENSE

# Copy debian_package build dependencies
define P64H_LIBS_EXTRAS
	$(call P64H_DEBIAN_PACKAGE_DEPS,$(@D))
endef

P64H_LIBS_POST_RSYNC_HOOKS += P64H_LIBS_EXTRAS

ifeq ($(BR2_PACKAGE_P64H_LIBS_OPENBLAS),y)
P64H_LIBS_LIST += openblas
endif

ifeq ($(BR2_PACKAGE_P64H_LIBS_OPENMPI),y)
P64H_LIBS_LIST += openmpi
endif

ifeq ($(BR2_PACKAGE_P64H_LIBS_LIBGFORTRAN),y)
P64H_LIBS_LIST += libgfortran
endif

ifeq ($(BR2_PACKAGE_P64H_LIBS_LIBC),y)
P64H_LIBS_LIST += libc
endif

ifeq ($(BR2_PACKAGE_P64H_LIBS_OPENMP),y)
P64H_LIBS_LIST += openmp
endif

ifeq ($(BR2_PACKAGE_P64H_LIBS_LLVM_DEVEL),y)
ifeq ($(call qstrip,$(RISCV_LLVM_PATH)),)
$(error RISCV_LLVM_PATH must be set to a valid path in order to build llvm-devel)
endif
ifeq ($(call qstrip,$(CROSS_LLVM_PATH)),)
$(error CROSS_LLVM_PATH must be set to a valid path in order to build llvm-devel)
endif
P64H_LIBS_LIST += llvm_devel
endif

ifeq ($(BR2_PACKAGE_P64H_LIBS_STD_DEVEL_LIBS),y)
ifeq ($(call qstrip,$(CROSS_LLVM_PATH)),)
$(error CROSS_LLVM_PATH must be set to a valid path in order to build std-devel-libs)
endif
P64H_LIBS_LIST += std_devel_libs
endif

# Invoke install stages
define P64H_LIBS_INSTALL_TARGET_CMDS
	$(foreach lib,$(P64H_LIBS_LIST), \
		$(call P64H_LIBS_INSTALL_$(call UPPERCASE,$(lib)))
	)
endef

# Generate post installation extra stages (used to build debian packages)
ifeq ($(P64H_DEBPKG_BUILD),1)
$(foreach lib,$(P64H_LIBS_LIST), \
	$(eval P64H_LIBS_POST_INSTALL_TARGET_HOOKS += P64H_LIBS_DEBIAN_PACKAGE_BUILD_$(call UPPERCASE,$(lib))); \
)
endif

$(eval $(generic-package))
