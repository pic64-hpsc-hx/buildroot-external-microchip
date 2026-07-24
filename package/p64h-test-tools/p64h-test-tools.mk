########################################################################################
#
# p64h-test-tools: Test tools that are required for running Test automation scripts
#
########################################################################################
P64H_TEST_TOOLS_VERSION = 1.0
P64H_TEST_TOOLS_SITE = $(BR2_EXTERNAL_MCHP_PATH)/package/p64h-test-tools
P64H_TEST_TOOLS_SITE_METHOD = local
P64H_EXAMPLES_BUILD_DIR = $(BUILD_DIR)/p64h-$(P64H_VERSION)

# Target directory for the installation
P64H_TEST_TOOLS_TARGET_DIR = /opt/microchip

define P64H_TEST_TOOLS_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)$(P64H_TEST_TOOLS_TARGET_DIR)/apprunner_uart
	$(INSTALL) -m 0644 $(P64H_EXAMPLES_BUILD_DIR)/examples/app_runner/uart_file_transfer.py $(TARGET_DIR)$(P64H_TEST_TOOLS_TARGET_DIR)/apprunner_uart/uart_file_transfer.py
endef

define P64H_TEST_TOOLS_INSTALL_P64H_TFPGA_SPI_MEM
        $(INSTALL) -m 0755 -D $(P64H_TEST_TOOLS_PKGDIR)/S03p64h_tfpga_spi_mem $(TARGET_DIR)/etc/init.d/S03p64h_tfpga_spi_mem
endef

ifeq ($(BR2_PACKAGE_P64H_TEST_TOOLS_TFPGA_SPI_MEM_DRIVER),y)
P64H_TEST_TOOLS_MODULE_SUBDIRS += ../p64h-$(P64H_VERSION)/drivers/p64h_tfpga_spi_mem
P64H_TEST_TOOLS_MODULE_LIST += p64h_tfpga_spi_mem
endif

$(eval $(generic-package))
