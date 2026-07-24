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

$(eval $(generic-package))
