########################################################################################
#
# p64h-test-automation: Test tools that are required for running Test automation scripts
#
########################################################################################
TEST_FILES_VERSION = 1.0
TEST_FILES_SITE = $(BR2_EXTERNAL_MICROCHIP_PATH)/package/p64h-test-tools
TEST_FILES_SITE_METHOD = local
# Target directory for the installation
P64H_TEST_TOOLS_TARGET_DIR = /opt/microchip

# Add the dependency here:
P64H_TEST_TOOLS_DEPENDENCIES = p64h-linux-examples

define P64H_TEST_TOOLS_INSTALL
	$(INSTALL) -d -m 0755 $(TARGET_DIR)$(P64H_TEST_AUTOMATION_TARGET_DIR)/apprunner_uart
	$(INSTALL) -m 0644 $(P64H_EXAMPLES_BUILD_DIR)/test-tools/uart_file_transfer.py $(TARGET_DIR)$(P64H_TEST_AUTOMATION_TARGET_DIR)/apprunner_uart/uart_file_transfer.py
endef

$(eval $(generic-package))