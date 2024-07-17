################################################################################
#
# p64h-lkms: Kernel Modules for P64H SoC
#
################################################################################

P64H_LKMS_SITE = $(P64H_TOPDIR)/drivers
P64H_LKMS_LICENSE = MIT
P64H_LKMS_LICENSE_FILES = LICENSE

ifeq ($(BR2_PACKAGE_P64H_LKMS_UIO_SHAREDMEM_DRIVER),y)
P64H_LKMS_MODULE_SUBDIRS += uio_sharedmem
endif

ifeq ($(BR2_PACKAGE_P64H_LKMS_UIO_GENDEV_DRIVER),y)
P64H_LKMS_MODULE_SUBDIRS += uio_gendev
endif

ifeq ($(BR2_PACKAGE_P64H_LKMS_UIO_MESA_DRIVER),y)
P64H_LKMS_MODULE_SUBDIRS += uio_mesa
endif

ifeq ($(BR2_PACKAGE_P64H_LKMS_APPDMA_DRIVER),y)
P64H_LKMS_MODULE_SUBDIRS += appdma
endif

# Fixup Linux Kernel configuration
define P64H_LKMS_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_MODULES)
	$(if BR2_PACKAGE_P64H_LKMS_UIO_SHAREDMEM_DRIVER,
		$(call KCONFIG_ENABLE_OPT,CONFIG_UIO))
	$(if BR2_PACKAGE_P64H_LKMS_UIO_GENDEV_DRIVER,
		$(call KCONFIG_ENABLE_OPT,CONFIG_UIO))
	$(if BR2_PACKAGE_P64H_LKMS_UIO_MESA_DRIVER,
		$(call KCONFIG_ENABLE_OPT,CONFIG_UIO))
	$(if BR2_PACKAGE_P64H_LKMS_APPDMA_DRIVER,
		$(call KCONFIG_ENABLE_OPT,CONFIG_DMA_VIRTUAL_CHANNELS))
endef

$(foreach d,$(P64H_LKMS_MODULE_SUBDIRS), \
	$(eval P64H_LKMS_POST_BUILD_HOOKS += P64H_LKMS_INSTALL_$(call UPPERCASE,$(d))); \
)

$(eval $(kernel-module))
$(eval $(generic-package))

