################################################################################
#
# p64h-lkms: Kernel Modules for PIC64-HPSC-HX SoC
#
################################################################################

P64H_LKMS_BUILD_DIR = $(BUILD_DIR)/p64h-$(P64H_VERSION)/drivers
P64H_LKMS_DEPENDENCIES = p64h
P64H_LKMS_MODULE_LIST =

ifeq ($(BR2_PACKAGE_P64H_LKMS_UIO_SHAREDMEM_DRIVER),y)
P64H_LKMS_MODULE_SUBDIRS += ../p64h-$(P64H_VERSION)/drivers/uio_sharedmem
P64H_LKMS_MODULE_LIST += uio_sharedmem
endif

ifeq ($(BR2_PACKAGE_P64H_LKMS_P64H_UIO_DRIVER),y)
P64H_LKMS_MODULE_SUBDIRS += ../p64h-$(P64H_VERSION)/drivers/p64h_uio
P64H_LKMS_MODULE_LIST += p64h_uio
endif

ifeq ($(BR2_PACKAGE_P64H_LKMS_APPDMA_DRIVER),y)
P64H_LKMS_MODULE_SUBDIRS += ../p64h-$(P64H_VERSION)/drivers/appdma
P64H_LKMS_MODULE_LIST += appdma
endif

ifeq ($(BR2_PACKAGE_P64H_LKMS_XSPI_DRIVER),y)
P64H_LKMS_MODULE_SUBDIRS += ../p64h-$(P64H_VERSION)/drivers/spi-microchip-p64h_xspi
P64H_LKMS_MODULE_LIST += spi-microchip-p64h_xspi
endif

ifeq ($(BR2_PACKAGE_P64H_LKMS_GPIO_DRIVER),y)
P64H_LKMS_MODULE_SUBDIRS += ../p64h-$(P64H_VERSION)/drivers/p64h_gpio
P64H_LKMS_MODULE_LIST += p64h_gpio
endif

ifeq ($(BR2_PACKAGE_P64H_LKMS_WDT_DRIVER),y)
P64H_LKMS_MODULE_SUBDIRS += ../p64h-$(P64H_VERSION)/drivers/p64h_wdt
P64H_LKMS_MODULE_LIST += p64h_wdt
endif

ifeq ($(BR2_PACKAGE_P64H_LKMS_HPT_DRIVER),y)
P64H_LKMS_MODULE_SUBDIRS += ../p64h-$(P64H_VERSION)/drivers/p64h_hpt
P64H_LKMS_MODULE_LIST += p64h_hpt
endif

ifeq ($(BR2_PACKAGE_P64H_LKMS_IPC_DEMO_DRIVER),y)
P64H_LKMS_MODULE_SUBDIRS += ../p64h-$(P64H_VERSION)/drivers/p64h_ipc
P64H_LKMS_MODULE_LIST += p64h_ipc_demo
endif

ifeq ($(BR2_PACKAGE_P64H_LKMS_PCIE_DRIVER),y)
P64H_LKMS_MODULE_SUBDIRS += ../p64h-$(P64H_VERSION)/drivers/p64h_pcie_cxl
P64H_LKMS_MODULE_LIST += p64h_pcie
endif

ifeq ($(BR2_PACKAGE_P64H_LKMS_MDIO_DRIVER),y)
P64H_LKMS_MODULE_SUBDIRS += ../p64h-$(P64H_VERSION)/drivers/p64h_mdio
P64H_LKMS_MODULE_LIST += p64h_mdio
endif

ifeq ($(BR2_PACKAGE_P64H_LKMS_X288_L2PF_DRIVER),y)
P64H_LKMS_MODULE_SUBDIRS += ../p64h-$(P64H_VERSION)/drivers/x288_l2pf
P64H_LKMS_MODULE_LIST += x288_l2pf
endif

# Fixup Linux Kernel configuration
define P64H_LKMS_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_MODULES)
	$(if BR2_PACKAGE_P64H_LKMS_UIO_SHAREDMEM_DRIVER,
		$(call KCONFIG_ENABLE_OPT,CONFIG_UIO))
	$(if BR2_PACKAGE_P64H_LKMS_P64H_UIO_DRIVER,
		$(call KCONFIG_ENABLE_OPT,CONFIG_UIO))
	$(if BR2_PACKAGE_P64H_LKMS_APPDMA_DRIVER,
		$(call KCONFIG_ENABLE_OPT,CONFIG_DMA_VIRTUAL_CHANNELS))
endef

# Post build installation stages (per module)
$(foreach d,$(P64H_LKMS_MODULE_LIST), \
	$(eval P64H_LKMS_POST_BUILD_HOOKS += P64H_LKMS_INSTALL_$(call UPPERCASE,$(d))); \
)

$(eval $(kernel-module))

# Post kernel installation stage
define P64H_LKMS_DEBIAN_PACKAGE_BUILD
	$(call P64H_DEBIAN_PACKAGE_SETUP,$(P64H_DEBPKG_SRC_DIR)/hpsc-kmods) \
	mkdir -p -m 0775 $(P64H_DEB_DIR)/lib/modules; \
	cp -r $(TARGET_DIR)/lib/modules/* $(P64H_DEB_DIR)/lib/modules/; \
	$(call P64H_DEBIAN_PACKAGE_BUILD)
endef

# Generate post kernel module installation extra stages (used to build debian packages)
# Note: This must be registered after $(eval $(kernel-module)) macro infra
ifeq ($(P64H_DEBPKG_BUILD),1)
$(eval P64H_LKMS_POST_INSTALL_TARGET_HOOKS += P64H_LKMS_DEBIAN_PACKAGE_BUILD);
endif

$(eval $(generic-package))
