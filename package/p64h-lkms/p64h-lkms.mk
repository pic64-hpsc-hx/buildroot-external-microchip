################################################################################
#
# p64h-lkms: Kernel Modules for PIC64-HPSC-HX SoC
#
################################################################################

P64H_LKMS_SITE = $(P64H_TOPDIR)/drivers
P64H_LKMS_LICENSE = MIT
P64H_LKMS_LICENSE_FILES = LICENSE

# Copy debian_package build dependencies
define P64H_LKMS_EXTRAS
	$(call P64H_DEBIAN_PACKAGE_DEPS,$(@D))
endef

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

ifeq ($(BR2_PACKAGE_P64H_LKMS_XSPI_DRIVER),y)
P64H_LKMS_MODULE_SUBDIRS += spi-microchip-p64h_xspi
endif

ifeq ($(BR2_PACKAGE_P64H_LKMS_GPIO_DRIVER),y)
P64H_LKMS_MODULE_SUBDIRS += p64h_gpio
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

# Post build installation stages (per module)
$(foreach d,$(P64H_LKMS_MODULE_SUBDIRS), \
	$(eval P64H_LKMS_POST_BUILD_HOOKS += P64H_LKMS_INSTALL_$(call UPPERCASE,$(d))); \
)

$(eval $(kernel-module))

# Post kernel installation stage
define P64H_LKMS_DEBIAN_PACKAGE_BUILD
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(@D)/debian_packages/hpsc-kmods) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/lib/modules; \
	cp -r $(TARGET_DIR)/lib/modules/* $(P64H_DEB_DIR)/lib/modules/; \
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

# Generate post kernel module installation extra stages (used to build debian packages)
# Note: This must be registered after $(eval $(kernel-module)) macro infra
ifeq ($(P64H_DEBPKG_BUILD),1)
P64H_LKMS_POST_RSYNC_HOOKS += P64H_LKMS_EXTRAS
$(eval P64H_LKMS_POST_INSTALL_TARGET_HOOKS += P64H_LKMS_DEBIAN_PACKAGE_BUILD);
endif

$(eval $(generic-package))

