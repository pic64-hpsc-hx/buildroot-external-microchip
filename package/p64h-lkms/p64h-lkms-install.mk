################################################################################
#
# p64h-lkms: Install
#
################################################################################

define P64H_LKMS_INSTALL_UIO_SHAREDMEM
	$(INSTALL) -m 0755 -D $(P64H_LKMS_PKGDIR)/S03uiosharedmem $(TARGET_DIR)/etc/init.d/S03uiosharedmem
endef

define P64H_LKMS_INSTALL_P64H_UIO
	$(INSTALL) -m 0755 -D $(P64H_LKMS_PKGDIR)/S03p64h_uio $(TARGET_DIR)/etc/init.d/S03p64h_uio
endef

define P64H_LKMS_INSTALL_SPI_MICROCHIP_P64H_XSPI
	$(INSTALL) -m 0755 -D $(P64H_LKMS_PKGDIR)/S03p64hxspi $(TARGET_DIR)/etc/init.d/S03p64hxspi
endef

define P64H_LKMS_INSTALL_P64H_GPIO
	$(INSTALL) -m 0755 -D $(P64H_LKMS_PKGDIR)/S03p64hgpio $(TARGET_DIR)/etc/init.d/S03p64hgpio
endef

define P64H_LKMS_INSTALL_P64H_WDT
	$(INSTALL) -m 0755 -D $(P64H_LKMS_PKGDIR)/S03p64hwdt $(TARGET_DIR)/etc/init.d/S03p64hwdt
endef

define P64H_LKMS_INSTALL_P64H_HPT
	$(INSTALL) -m 0755 -D $(P64H_LKMS_PKGDIR)/S03p64hhpt $(TARGET_DIR)/etc/init.d/S03p64hhpt
endef

define P64H_LKMS_INSTALL_P64H_IPC
	$(INSTALL) -m 0755 -D $(P64H_LKMS_PKGDIR)/S03p64hipc $(TARGET_DIR)/etc/init.d/S03p64hipc
endef

define P64H_LKMS_INSTALL_P64H_PCIE
	$(INSTALL) -m 0755 -D $(P64H_LKMS_PKGDIR)/S03p64hpcie $(TARGET_DIR)/etc/init.d/S03p64hpcie
endef
