################################################################################
#
# p64h-lkms: Install
#
################################################################################

define P64H_LKMS_INSTALL_UIO_SHAREDMEM
	$(INSTALL) -m 0755 -D $(P64H_LKMS_PKGDIR)S03uiosharedmem $(TARGET_DIR)/etc/init.d/S03uiosharedmem
endef

define P64H_LKMS_INSTALL_UIO_GENDEV
	$(INSTALL) -m 0755 -D $(P64H_LKMS_PKGDIR)S03uiogendev $(TARGET_DIR)/etc/init.d/S03uiogendev
endef

define P64H_LKMS_INSTALL_UIO_MESA
	$(INSTALL) -m 0755 -D $(P64H_LKMS_PKGDIR)S03uiomesa $(TARGET_DIR)/etc/init.d/S03uiomesa
endef

define P64H_LKMS_INSTALL_SPI_MICROCHIP_P64H_XSPI
	$(INSTALL) -m 0755 -D $(P64H_LKMS_PKGDIR)S03p64hxspi $(TARGET_DIR)/etc/init.d/S03p64hxspi
endef
