################################################################################
#
# p64h-libs: Shared Libraries for PIC64-HPSC-HX SoC.
#
################################################################################

P64H_LIBS_BUILD_DIR=$(BUILD_DIR)/p64h-$(P64H_VERSION)/install/libs
P64H_LIBS_DEPENDENCIES = p64h

# Copy debian_package build dependencies
define P64H_LIBS_EXTRAS
	$(call P64H_DEBIAN_PACKAGE_DEPS,$(P64H_LIBS_BUILD_DIR))
endef

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

# Invoke install stages
define P64H_LIBS_INSTALL_TARGET_CMDS
	$(foreach lib,$(P64H_LIBS_LIST), \
		$(call P64H_LIBS_INSTALL_$(call UPPERCASE,$(lib)))
	)
endef

# Generate post installation extra stages (used to build debian packages)
ifeq ($(P64H_DEBPKG_BUILD),1)
P64H_LIBS_POST_RSYNC_HOOKS += P64H_LIBS_EXTRAS
$(foreach lib,$(P64H_LIBS_LIST), \
	$(eval P64H_LIBS_POST_INSTALL_TARGET_HOOKS += P64H_LIBS_DEBIAN_PACKAGE_BUILD_$(call UPPERCASE,$(lib))); \
)
endif

$(eval $(generic-package))
