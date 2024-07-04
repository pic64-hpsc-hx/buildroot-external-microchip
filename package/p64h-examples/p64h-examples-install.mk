################################################################################
#
# p64h-examples: Install
#
################################################################################

define P64H_EXAMPLES_INSTALL_HELLO
	rm -rf $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/hpsc_hello
	$(INSTALL) -D -m 0755 $(@D)/examples/hello/hpsc_hello $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/hpsc_hello
endef

define P64H_EXAMPLES_INSTALL_SHAREDMEM
	rm -rf $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/hpsc_sharedmem
	$(INSTALL) -D -m 0755 $(@D)/examples/sharedmem/hpsc_sharedmem $(TARGET_DIR)$(P64H_EXAMPLES_TARGET_DIR)/hpsc_sharedmem
endef