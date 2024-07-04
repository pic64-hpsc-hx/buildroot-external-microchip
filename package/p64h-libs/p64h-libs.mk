################################################################################
#
# p64h-libs: Shared Libraries
#
################################################################################

P64H_LIBS_SITE = $(P64H_TOPDIR)
P64H_LIBS_SITE_METHOD = local
P64H_LIBS_LICENSE = MIT
P64H_LIBS_LICENSE_FILES = LICENSE

ifeq ($(BR2_PACKAGE_P64H_LIBS_OPENBLAS),y)
P64H_LIBS_LIST += openblas
endif

ifeq ($(BR2_PACKAGE_P64H_LIBS_OPENMPI),y)
P64H_LIBS_LIST += openmpi
endif

ifeq ($(BR2_PACKAGE_P64H_LIBS_LIBFORTRAN),y)
P64H_LIBS_LIST += libfortran
endif

ifeq ($(BR2_PACKAGE_P64H_LIBS_LIBC),y)
P64H_LIBS_LIST += libc
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